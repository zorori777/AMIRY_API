module APIComponents
  module Controllers
    class BandsController < ApiController
      before do
        if user_debug_id = headers['User-Debug-Id']
          @user = User.find(user_debug_id)
        else
          jwt_token = headers['JWT_token']
          @user = External::Jwt::JwtHandler.new.user_by(token: jwt_token)
        end
      end

      desc 'Return all bands' do
        http_codes([
          { code: 200, message: 'Band', model: Entities::Band }
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
        optional :circle_id,   type: Integer,        desc: 'The id of the circle that the band belongs to.'
        requires :name,        type: String,         desc: 'The name of the band.'
        requires :concept,     type: String,         desc: 'The concept of the band.'
        requires :description, type: String,         desc: 'The description of the band.'
        requires :type,        type: Integer,        desc: 'The type of the band. only_men: 1, only_women: 2, mix: 3, sub_only_men: 4, sub_only_women: 5'
        requires :united_at,   type: DateTime,       desc: 'When the band got united_at.'
        requires :user_ids,    type: Array[Integer], desc: 'Ids of the users who joins the band.'
        optional :image_file,  type: Array[File],    desc: 'The image files of the band.'
      end
      post '/' do
        band = Band.new(
          name: params[:name], concept: params[:concept], type: params[:type],
          description: params[:description], united_at: params[:united_at], circle_id: params[:circle_id]
        )
        begin
          ActiveRecord::Base.transaction do
            band.save!
            if params[:image_file].present?
              params[:image_file].size.times do |num|
                band.band_images << BandImage.new(name: params[:image_file][num])
              end
            end
            if params[:user_ids].present?
              params[:user_ids].size.times do |num|
                band.user_bands << UserBand.new(user_id: params[:user_ids][num])
              end
            end
            present band, with: Entities::Band
          end
        rescue => error
          Errors::InternalServerError.new(message: error)
        end
      end

      # destroy
      desc 'Delete a new band.' do
        headers(
          JWT_token:     { description: 'JWT Token.', required: false },
          user_debug_id: { description: 'Debug id.',  required: false }
        )
      end
      params do
        requires :id, type: Integer, desc: 'The id of the band.'
      end
      delete '/:id' do
        band = Band.find(params[:id])
        unless @user.joins_band?(band: band)
          Errors::UnauthorizedError.new(detail: 'The signed-in user does not belong to the user.')
        end
        band.destroy
      end
    end
  end
end
