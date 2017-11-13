module APIComponents
  module Controllers
    module Circle
      class Overview < ApiController
        desc 'Get public profile for specified company' do
          detail <<~DETAIL
              Get a overview for a circle who has the same id as the given param id.
          DETAIL
          http_codes([
            { code: 200, message: 'circle', model: Entities::Circle::Overview }
          ])
        end

        params do
          requires :id, type: Integer, description: 'the id of the circle'
        end

        get '/:id' do
          circle = ::Circle.find(params[:id])

          present circle, Entities::Circle::Overview
        end
      end
    end
  end
end
