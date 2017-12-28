module APIComponents
  module Controllers
    class CirclesController < ApiController
      # index
      desc 'Return all Cirlcle objects' do
        http_codes([
          { code: 200, message: 'circle', model: Entities::Circle }
        ])
      end
      get '/' do
        present Circle.includes(:university).page(params[:page]), with: Entities::Circle
      end

      # show
      desc 'Return a circle.' do
        detail <<~DETAIL
          Returns a Circle Object
        DETAIL
        http_codes([
          { code: 200, message: 'Circle', model: Entities::Circle }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'Circle id.'
      end
      get '/:id' do
        present Circle.find(params[:id]), with: Entities::Circle
      end
    end
  end
end
