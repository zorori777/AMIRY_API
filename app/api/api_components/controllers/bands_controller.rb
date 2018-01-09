module APIComponents
  module Controllers
    class BandsController < ApiController
      desc 'Return all bands' do
        http_codes([
          { code: 200, message: 'circle', model: Entities::Band }
        ])
      end
      params do
        optional :page, type: Integer, desc: 'Page Num'
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

      # create
      desc 'Create a new band.' do
        detail <<~DETAIL
          Creates a Band Object
        DETAIL
        http_codes([
          { code: 200, message: 'Circle', model: Entities::Band }
        ])
      end
      params do
        optional :circle_id
        requires :name
        requires :concept
        requires :description
        requires :people_num, type: Integer
        requires :type, type: Integer
        requires :united_at, type: DateTime
        optional :image_file, type: Array[File]
      end
      post '/' do
        band = Band.new(
          name: params[:name], concept: params[:concept], type: params[:type],
          description: params[:description], people_num: params[:people_num],
          united_at: params[:united_at], circle_id: params[:circle_id]
        )

        begin
          ActiveRecord::Base.transaction do
            band.save!
            params[:image_file].size.times do |num|
              band.band_images << BandImage.new(name: params[:image_file][num])
            end
            present band, with: Entities::Band
          end
        rescue => error
          Errors::InternalServerError.new(message: error)
        end
      end
    end
  end
end
