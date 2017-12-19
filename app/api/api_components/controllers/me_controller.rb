module APIComponents
  module Controllers
    class MeController < APIRoot
      include External::Facebook

      version 'v1', using: :path
      format :json

      before do
        # TODO NEED TO DELETE THIS FOR PRODUCTION
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          facebook_token      = headers['Facebook_Token']
          facebook_id         = headers['Facebook_Id']
          user_facebook_info = External::Facebook::GraphApiHandler.new(facebook_token: facebook_token, facebook_id: facebook_id)

          unless user_facebook_info.valid_facebook_id_and_token?
            Errors::UnauthorizedError.new(detail: 'Facebook Authentication Did Not Pass.')
          end

          @user = User.find_by(facebook_id: user_facebook_info.facebook_id)
        end
      end

      desc 'GET /api/v1/me' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::User }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false },
        )
      end
      get '/' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user, with: Entities::User
      end

      desc 'POST /api/v1/me' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::User }
        ])
      end
      params do
        requires :facebook_id,    type: Integer, desc: 'The id of the user on facebook'
        requires :facebook_token, type: String,  desc: 'The access token provided by JS Facebook SDK.'
      end
      post '/' do
        user = User.create_from_graph_api(user_facebook_info: @user_facebook_info)
        present user, with: Entities::User
      end

      desc 'GET /me/introductions' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::Introduction }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false },
        )
      end
      get '/introductions' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.introductions, with: Entities::Introduction
      end
    end
  end
end
