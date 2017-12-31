module APIComponents
  module Controllers
    class LivesController < ApiController
      # index
      desc 'Return all lives' do
        http_codes([
          { code: 200, message: 'live', model: Entities::Live }
        ])
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
      end
      get '/' do
        present Live.includes(:user).newest.passed.page(params[:page]), with: Entities::Live
      end

      # show
      desc 'Return a Live Object' do
        http_codes([
          { codes: 200, message: 'live', model: Entities::Live }
        ])
      end
      params do
        requires :id, type: Integer, desc: 'the id of the live.'
      end
      get '/:id' do
        live = Live.find_by(id: params[:id])
        unless live.present?
          Errors::RecordNotFoundError.new(id: params[:id], model: 'live')
        end
        present Live.find(params[:id]), with: Entities::Live
      end
    end
  end
end
