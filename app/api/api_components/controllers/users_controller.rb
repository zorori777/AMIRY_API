module APIComponents
  module Controllers
    class UsersController < ApiController
      version 'v1', using: :path
      format :json

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
    end
  end
end
