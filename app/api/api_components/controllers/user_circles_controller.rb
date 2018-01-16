module APIComponents
  module Controllers
    class UserCirclesController < ApiController
      desc 'Create UserCircles Object' do
        http_codes([
          { code: 200, message: 'UserCircle', model: Entities::UserCircle }
        ])
      end
      params do
        requires :user_ids,  type: Array[Integer], desc: 'The ids of the user.'
        requires :circle_id, type: Integer,        desc: 'The id of the circle.'
      end
      post '/' do
        circle = Circle.find(params[:circle_id])
        unless circle.present?
          Errors::RecordNotFoundError.new(id: params['circle_id'], model: 'Circle')
        end

        params[:user_ids].size.times do |num|
          circle.user_circles << UserCircle.new(circle_id: params[:circle_id], user_id: params[:user_ids][num])
        end

        present :ok
      end
    end
  end
end
