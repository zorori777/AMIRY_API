module APIComponents
  module Controllers
    class UserLivesController < ApiController
      desc 'Create UserLives Object' do
        http_codes([
          { code: 200, message: 'UserLive', model: Entities::UserLive }
        ])
      end
      params do
        requires :user_ids, type: Array[Integer], desc: 'The ids of the user.'
        requires :live_id,  type: Integer,        desc: 'The id of the live.'
      end
      post '/' do
        live = Live.find(params[:live_id])
        unless live.present?
          Errors::RecordNotFoundError.new(id: params['live_id'], model: 'Live')
        end

        params[:user_ids].size.times do |num|
          live.user_lives << UserLive.new(live_id: params[:live_id], user_id: params[:user_ids][num])
        end

        present :ok
      end
    end
  end
end
