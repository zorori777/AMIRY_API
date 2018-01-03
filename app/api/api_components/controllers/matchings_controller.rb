module APIComponents
  module Controllers
    class MatchingsController < ApiController
      # create
      desc 'Create a matching.' do
        detail <<~DETAIL
          Create a new introduction object
        DETAIL
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Matching },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
      end
      params do
        requires :like_id,      type: Integer, desc: 'The id of the like that the recipient approved.'
        requires :recipient_id, type: Integer, desc: 'The id of the user who receives the introduction.'
        requires :sender_id,    type: Integer, desc: 'The id of the user who sends the introduction.'
      end
      post '/' do
        matching = Matching.new(like_id: params[:like_id], recipient_id: params[:recipient_id], sender_id: params[:sender_id])
        matching.save!
        present matching, with: Entities::Matching
      end
    end
  end
end
