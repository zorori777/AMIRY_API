module APIComponents
  module Controllers
    class MessagesController < ApiController
      # create
      desc 'Create a message.' do
        headers(
          JWT_token:     { description: 'JWT Token.', required: false },
          user_debug_id: { description: 'Debug id.',  required: false }
        )
      end
      params do
        requires :recipient_id, type: Integer, desc: 'The id of the recipient'
        optional :body,         type: String,  desc: 'The body of the message.'
        optional :image,        type: File,    desc: 'The image of the message.'
      end
      post '/' do
        message = Message.new(params)
        message.sender_id = @user.id
        begin
          message.save!
          present message, with: Entities::Message
        rescue => error
          Errors::InternalServerError.new(message: error)
        end
      end
    end
  end
end
