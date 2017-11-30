module APIComponents
  module Controllers
    class MeController < APIRoot
      include External::Facebook

      version 'v1', using: :path
      format :json

      desc 'GET /api/v1/me' do
        http_codes([
          { code: 200, message: 'User Object', model: Entities::User }
        ])
      end
      get '/:id' do
        present User.find(params[:id]), with: Entities::User
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
        user_object = External::Facebook::GraphApiHandler.new(facebook_token: params[:facebook_token], facebook_id: params[:facebook_id])

        # TODO: falseが返ってきたときに、errorのjsonを返さないといけない。
        # return unless user_object.valid_facebook_id_and_token?

        user = User.create_from_graph_api(user_object: user_object)
        present user, with: Entities::User
      end
    end
  end
end
