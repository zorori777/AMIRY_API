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
        present Live.includes(:circle, :live_images).in_newest_order.without_passed.page(params[:page]), with: Entities::Live
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

      # create
      desc 'Create a new Live Object.' do
        http_codes([
          { codes: 200, message: 'live', model: Entities::Live }
        ])
      end
      params do
        optional :circle_id,   type: Integer,  desc: 'The id of the circle.'
        requires :name,        type: String,   desc: 'The name of the live.'
        requires :description, type: String,   desc: 'The description of the live.'
        requires :hold_at,     type: DateTime, desc: 'When the live is to be held at.'
        optional :image_file,  type: File,     desc: 'The image files for the live.'
      end
      post '/' do
        live = Live.new(name: params[:name], description: params[:description], hold_at: params[:hold_at])
        live.circle = Circle.find_by(id: params[:circle_id])
        live.live_images.build(name: params[:image_file])
        begin
          live.save!
          present live, with: Entities::Live
        rescue => error
          Errors::InternalServerError.new(message: error.message)
        end
      end
    end
  end
end
