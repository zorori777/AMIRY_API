module APIComponents
  module Controllers
    class UsersController < ApiController
      version 'v1', using: :path
      format :json

      before do
        # TODO NEED TO DELETE THIS FOR PRODUCTION
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          facebook_token     = headers['Facebook_Token']
          facebook_id        = headers['Facebook_Id']
          user_facebook_info = External::Facebook::GraphApiHandler.new(facebook_token: facebook_token, facebook_id: facebook_id)

          unless user_facebook_info.valid_facebook_id_and_token?
            Errors::UnauthorizedError.new(detail: 'Facebook Authentication Did Not Pass.')
          end

          @user = User.find_by(facebook_id: user_facebook_info.facebook_id)
        end
      end

      # index
      desc '/' do
        http_codes([
          { code: 200, message: 'User',  model: Entities::User },
          { code: 400, message: 'Error', model: Entities::Error },
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
        )
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/' do
        present User.includes(:university).page(params[:page]), with: Entities::User
      end

      # show
      desc '/' do
        http_codes([
          { code: 200, message: 'User',  model: Entities::User },
          { code: 400, message: 'Error', model: Entities::Error },
        ])
        headers(
          facebook_id:    { description: 'The id of the user on facebook',             required: false },
          facebook_token: { description: 'The access token provided by Facebook SDK.', required: false },
          user_debug_id:  { description: 'Debug id.', required: false },
        )
      end
      get '/:id' do
        user_id = params[:id].to_i
        user = User.find(user_id)
        unless user.present?
          Errors::RecordNotFoundError.new(id: user_id, model: 'User')
        end
        present user, with: Entities::User
      end
    end
  end
end
