module APIComponents
  module Controllers
    class CirclesController < ApiController
      desc 'Return an Circle.' do
        http_codes([
           { code: 200, message: 'circle', model: Entities::Circle }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'Circle id.'
      end
      route_param :id do
        get do
          present Circle.find(params[:id]), with: Entities::Circle
        end
      end
    end
  end
end
