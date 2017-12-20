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
      post '' do
        introduction = Introduction.new(params)
        introduction.save!
        present introduction, with: Entities::Introduction
      end
    end
  end
end
