module APIComponents
  module Controllers
    class UniversitiesController < ApiController
      desc 'Return all universities' do
        http_codes([
          { code: 200, message: 'circle', model: Entities::University }
        ])
      end
      params do
        optional :page, type: Integer, desc: "Page Num"
      end
      get '/' do
        present University.all.page(params[:page]), with: Entities::University
      end
    end
  end
end