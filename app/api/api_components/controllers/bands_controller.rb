module APIComponents
  module Controllers
    class BandsController < ApiController
      desc 'Return all bands' do
        http_codes([
          { code: 200, message: 'circle', model: Entities::Band }
        ])
      end
      params do
        optional :page, type: Integer, desc: "Page Num"
      end
      get '/' do
        present Band.includes(:circle).all.page(params[:page]), with: Entities::Band
      end

      # show
      desc 'Return a band.' do
        detail <<~DETAIL
          Returns a Band Object
        DETAIL
        http_codes([
          { code: 200, message: 'Circle', model: Entities::Band }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'Circle id.'
      end
      get '/:id' do
        present Band.find(params[:id]), with: Entities::Band
      end
    end
  end
end
