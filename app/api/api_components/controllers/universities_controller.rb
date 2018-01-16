module APIComponents
  module Controllers
    class UniversitiesController < ApiController
      # index
      desc 'Return all universities' do
        http_codes([
          { code: 200, message: 'University', model: Entities::University }
        ])
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/' do
        present University.includes(:circles).page(params[:page]), with: Entities::University
      end

      # show
      desc 'Return one single university object' do
        http_codes([
          { code: 200, message: 'University', model: Entities::University }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'The id of the university.'
      end
      get '/:id' do
        present University.find(params[:id]), with: Entities::University
      end
    end
  end
end
