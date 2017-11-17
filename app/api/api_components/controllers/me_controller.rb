module APIComponents
  module Controllers
    class MeController < APIRoot
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
      post '/facebook' do
        binding.pry
        { message: 'test'}
      end
    end
  end
end
