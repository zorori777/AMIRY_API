module APIComponents
  module Controllers
    class MeController < APIRoot
      include External::Facebook

      version 'v1', using: :path
      format :json

      before do
        facebook_token      = params['facebook_token']
        facebook_id         = params['facebook_id']
        @user_facebook_info = External::Facebook::GraphApiHandler.new(facebook_token: facebook_token, facebook_id: facebook_id)

        unless @user_facebook_info.valid_facebook_id_and_token?
          Errors::UnauthorizedError.new(detail: 'Facebook Authentication Did Not Pass.')
        end
      end

      desc 'GET /api/v1/me' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::User }
        ])
      end
      params do
        requires :facebook_id,    type: Integer, desc: 'The id of the user on facebook'
        requires :facebook_token, type: String,  desc: 'The access token provided by Facebook SDK.'
      end
      get '/' do
        user_object = User.find_by(facebook_id: @user_facebook_info.facebook_id)
        unless user_object.present?
          Errors::RecordNotFoundError.new(id: params[:facebook_id], model: 'User')
        end
        present user_object, with: Entities::User
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
        user = User.create_from_graph_api(user_facebook_info: @user_on_facebook)
        present user, with: Entities::User
      end
    end
  end
end
