module APIComponents
  module Controllers
    class MeController < APIRoot
      include External::Facebook
      include External::JWT

      version 'v1', using: :path
      format :json

      before do
        # TODO: NEED TO DELETE THIS FOR PRODUCTION
        if request.env['REQUEST_PATH'] == '/api/v1/me'
          @user_facebook_info = External::Facebook::GraphApiHandler.new(facebook_token: params[:facebook_token], facebook_id: params[:facebook_id])

          unless @user_facebook_info.valid_facebook_id_and_token?
            Errors::UnauthorizedError.new(detail: 'Facebook Authentication Did Not Pass.')
          end

          @user_facebook_info
        elsif user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
        end
      end

      desc 'GET /api/v1/me' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::User }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
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
        unless @user_facebook_info.valid_facebook_id_and_token?
          Errors::UnauthorizedError.new(detail: 'Facebook Authentication Did Not Pass.')
        end
        user = User.create_from_graph_api(user_facebook_info: @user_facebook_info)
        FBFriend::Inserter.perform_async(user.id, @user_facebook_info.facebook_friends)
        present user, with: Entities::User
      end

      desc 'GET /me/articles' do
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Article },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false }
        )
      end
      get '/articles' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.articles, with: Entities::Article
      end

      desc 'GET /me/bands' do
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Band },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.',                                  required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/bands' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.bands, with: Entities::Band
      end

      desc 'GET /me/circles' do
        http_codes([
          { code: 200, message: 'Circle', model: Entities::Circle },
          { code: 400, message: 'Error',  model: Entities::Error  }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.',                                  required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/circles' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.circles, with: Entities::Circle
      end

      desc 'GET /me/introductions' do
        http_codes([
          { code: 200, message: 'Introduction', model: Entities::Introduction },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/introductions' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.introductions, with: Entities::Introduction
      end

      desc 'GET /me/lectures' do
        http_codes([
          { code: 200, message: 'Lecture', model: Entities::Lecture },
          { code: 400, message: 'Error',   model: Entities::Error }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/lectures' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.lectures.recent, with: Entities::Lecture
      end

      desc 'GET /me/matchings' do
        http_codes([
          { code: 200, message: 'Matching', model: Entities::Matching },
          { code: 400, message: 'Error',    model: Entities::Error    }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.',                                  required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/matchings' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.matchings, with: Entities::Matching
      end

      desc 'GET /me/notifications' do
        http_codes([
          { code: 200, message: 'Notification', model: Entities::Notification },
          { code: 400, message: 'Error',        model: Entities::Error }
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook.',          required: false },
          facebook_token: { description: 'The token of the user on facebook token.', required: false },
          user_debug_id:  { description: 'Debug id.',                                required: false }
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/notifications' do
        unless @user.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present @user.notifications, with: Entities::Notification
      end
    end
  end
end
