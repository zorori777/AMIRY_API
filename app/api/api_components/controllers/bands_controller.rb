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
    end
  end
end
