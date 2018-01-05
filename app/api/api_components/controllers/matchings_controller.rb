module APIComponents
  module Controllers
    class MatchingsController < ApiController
      # create
      desc 'Create a matching.' do
        detail <<~DETAIL
          Create a new matching object
        DETAIL
        http_codes([
          { code: 200, message: 'Matching', model: Entities::Matching },
          { code: 400, message: 'Error',    model: Entities::Error }
        ])
      end
      params do
        requires :like_id,      type: Integer, desc: 'The id of the like that the recipient approved.'
        requires :recipient_id, type: Integer, desc: 'The id of the user who receives the matching.'
        requires :sender_id,    type: Integer, desc: 'The id of the user who sends the introduction.'
      end
      post '/' do
        matching = Matching.new(like_id: params[:like_id], recipient_id: params[:recipient_id], sender_id: params[:sender_id])
        matching.save!
        present matching, with: Entities::Matching
      end

      # Update
      desc 'Update the given matching.' do
        detail <<~DETAIL
          Update the given matching object.
        DETAIL
        http_codes([
          { code: 200, message: 'Matching', model: Entities::Matching },
          { code: 400, message: 'Error',    model: Entities::Error }
        ])
      end
      params do
        requires :id,         type: Integer, desc: 'The id of the matching.'
        requires :acceptance, type: Integer, desc: 'The acceptance of the matching.'
      end
      post '/' do
        matching = Matching.find_by(id: params[:id])
        unless matching.present?
          Errors::RecordNotFoundError.new(id: params[:id], model: 'Matching')
        end
        matching.update_acceptance!(acceptance: params[:acceptance])
        Notifiers::Matching.perform_async(matching.sender_id, matching.recipient_id)
        Inserters::Matching.perform_async(matching.sender_id, matching.recipient_id, matching.id)
        present matching, with: Entities::Matching
      end
    end
  end
end
