module APIComponents
  module Controllers
    class LikesController < ApiController
      # create
      desc 'Create a like.' do
        detail <<~DETAIL
          Create a new like object
        DETAIL
        http_codes([
          { code: 200, message: 'Like',  model: Entities::Like },
          { code: 400, message: 'Error', model: Entities::Error }
        ])
      end
      params do
        requires :sender_id,    type: Integer, desc: 'The id of the user who sends the like.'
        requires :recipient_id, type: Integer, desc: 'The id of the user who receives the like.'
      end
      post '/' do
        like = Like.new(recipient_id: params[:recipient_id], sender_id: params[:sender_id])
        begin
          like.save!
          Inserters::Like::Request.perform_async(like.id)
          Notifiers::Like::Request.perform_async(like.id)
          present like, with: Entities::like
        rescue => error
          Errors::InternalServerError.new(message: error)
        end
      end

      # Update
      desc 'Update the given like.' do
        detail <<~DETAIL
          Update the given like object.
        DETAIL
        http_codes([
          { code: 200, message: 'Like',  model: Entities::Like },
          { code: 400, message: 'Error', model: Entities::Error }
        ])
      end
      params do
        requires :id,         type: Integer, desc: 'The id of the matching.'
        requires :acceptance, type: Integer, desc: 'The acceptance of the like.'
      end
      put '/' do
        like = Like.find_by(id: params[:id])
        new_acceptance = params[:acceptance]
        unless like.present?
          Errors::RecordNotFoundError.new(id: params[:id], model: 'Like')
        end

        like.acceptance = new_acceptance

        if like.accepted?
          ActiveRecord::Base.transaction do
            like.update_acceptance!(acceptance: new_acceptance)
            matching = Matching.new(like_id: like.id, sender_id: like.sender_id, recipient_id: like.recipient_id)
            matching.save!
          end

          Notifiers::Like::Approval.perform_async(like.id)
          Inserters::Like::Approval.perform_async(like.id)

          present like, with: Entities::Like
        end
      end
    end
  end
end
