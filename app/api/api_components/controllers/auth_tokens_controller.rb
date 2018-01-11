module APIComponents
  module Controllers
    class AuthTokensController < ApiController
      include External::Jwt

      desc 'Get JWT token.' do
        http_codes([
          { code: 200, message: 'Jwt', model: Entities::Jwt }
        ])
      end
      params do
        requires :facebook_id, type: Integer,  desc: 'The id of the user on facebook.'
        requires :email,       type: String,   desc: 'The email of the user.'
        requires :created_at,  type: DateTime, desc: 'When the user got created.'
      end
      get '/' do
        jwt_handler = External::Jwt::JwtHandler.new(facebook_id: params[:facebook_id], email: params[:email], created_at: params[:created_at])
        token = jwt_handler.encodes
        present token, with: Entities::Jwt
      end
    end
  end
end
