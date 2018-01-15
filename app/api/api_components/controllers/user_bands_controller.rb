module APIComponents
  module Controllers
    class UserBandsController < ApiController
      # create
      desc 'Create UserBand Objects' do
        http_codes([
          { code: 200, message: 'UserBand', model: Entities::UserBand }
        ])
      end
      params do
        requires :user_ids, type: Array[Integer], desc: 'The ids of the user.'
        requires :band_id,  type: Integer,        desc: 'The id of the band.'
      end
      post '/' do
        band = Band.find_by(id: params[:band_id])
        unless band.present?
          Errors::RecordNotFoundError.new(id: params[:band_id], model: 'Band')
        end

        if band.additional_people_num_within_range?(additional_people_num: params[:user_ids].size)
          Errors::BadRequestError.new(message: 'Band\'s people num is out of the range.')
        end

        user_bands = params[:user_ids].map do |user_id|
          user_band = UserBand.new(band_id: params[:band_id], user_id: user_id)
          user_band.save!
        end

        present user_bands, with: Entity::UserBand
      end

      # destroy
      desc 'Destroy UserBand Objects' do
        http_codes([
          { code: 200, message: 'UserBand', model: Entities::UserBand }
        ])
      end
      params do
        requires :user_ids, type: Array[Integer], desc: 'The ids of the user.'
        requires :band_id,  type: Integer,        desc: 'The id of the band.'
      end
      delete '/' do
        band = Band.find_by(id: params[:band_id])
        unless band.present?
          Errors::RecordNotFoundError.new(id: params[:band_id], model: 'Band')
        end

        begin
          band.destroy!
          present band, with: Entities::Band
        rescue => error
          Errors::InternalServerError.new(message: error)
        end
      end
    end
  end
end
