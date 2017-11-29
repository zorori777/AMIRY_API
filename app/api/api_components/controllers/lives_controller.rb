module APIComponents
  module Controllers
    class LivesController < ApiController
      desc 'Return all lives' do
        http_codes([
          { code: 200, message: 'circle', model: Entities::Live }
      ])
      end
      params do
        optional :page, type: Integer, desc: "Page Num"
      end
      get '/' do
        present Live.includes(:circle).recent.all.page(params[:page]), with: Entities::Live
      end
    end
  end
end
