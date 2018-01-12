module APIComponents
  module Controllers
    class MessagesController < ApiController
      before do
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
        end
      end

      # index
      desc 'Get Messages.' do
        headers(
          JWT_token:     { description: 'JWT Token.', required: false },
          user_debug_id: { description: 'Debug id.',  required: false }
        )
        http_codes([
          { code: 200, message: 'Message', model: Entities::Message }
        ])
      end
      params do
        requires :recipient_id, type: Integer, desc: 'The id of the recipient.'
      end
      get '/' do
        messages = Message.where(sender_id: @user.id, recipient_id: params[:recipient_id]).includes(:sender, :recipient)
        present messages, with: Entities::Message
      end

      # create
      desc 'Create a message.' do
        headers(
          JWT_token:     { description: 'JWT Token.', required: false },
          user_debug_id: { description: 'Debug id.',  required: false }
        )
        http_codes([
          { code: 200, message: 'Message', model: Entities::Message }
        ])
      end
      params do
        requires :recipient_id, type: Integer, desc: 'The id of the recipient.'
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
