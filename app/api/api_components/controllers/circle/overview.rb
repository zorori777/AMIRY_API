module APIComponents
  module Controllers
    module Circle
      class Overview < ApiController
        desc 'Get public profile for specified company' do
          detail <<~DETAIL
              Get a profile for a professional who has the same id as the given param id.
          DETAIL
          http_codes([
            { code: 200, message: 'Professional', model: Entities::Circle::Overview }
          ])
        end

        params do
          requires :id, type: Integer, description: 'the id of the professional'
        end
      end
    end
  end
end
