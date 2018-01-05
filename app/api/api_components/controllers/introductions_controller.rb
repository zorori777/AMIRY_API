module APIComponents
  module Controllers
    class IntroductionsController < ApiController
      # create
      desc 'Create a new introduction object' do
        detail <<~DETAIL
          Create a new introduction object
        DETAIL
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Introduction },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
      end
      params do
        requires :recipient_id, type: Integer, desc: 'The id of the user who receives the introduction.'
        requires :sender_id,    type: Integer, desc: 'The id of the user who sends the introduction.'
        requires :description,  type: String,  desc: 'The content of the introduction.'
      end
      post '/' do
        introduction = Introduction.new(params)
        introduction.save!
        present introduction, with: Entities::Introduction
      end

      # update
      desc 'Update introduction object.' do
        detail <<~DETAIL
          Update the given introduction object\'s acceptance status.
        DETAIL
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Introduction },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
      end
      params do
        requires :id,         type: Integer, desc: 'The primary id of the introduction object.'
        requires :acceptance, type: Integer, desc: 'The status of the acceptance. accepted: 1, pending: 2, rejected: 3'
      end
      put '/' do
        introduction = Introduction.find_by(id: params[:id])
        unless introduction.present?
          Errors::RecordNotFoundError.new(id: params[:id], model: 'Introduction')
        end

        ActiveRecord::Base.transaction do
          introduction.update!(acceptance: params[:acceptance])
          introduction.sender.add_bonus_likes_count
        end

        Notifiers::Introduction.perform(introduction.sender_id, introduction.recipient_id)
        Inserters::Introduction.perform(introduction.sender_id, introduction.recipient_id, introduction.id)

        present introduction, with: Entities::Introduction
      end
    end
  end
end
