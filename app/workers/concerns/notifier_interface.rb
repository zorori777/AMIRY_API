require 'json'
require 'dotenv'

Dotenv.overload

module NotifierInterface
  extend ActiveSupport::Concern

  included do
    def send_push_notification(body:, player_ids:)
      return unless body.present? || player_ids.present?

      request_body = {
          app_id:             ENV['ONE_SIGNAL_APP_ID'],
          contents:           { ja: body, en: body },
          include_player_ids: player_ids
      }

      request_json = request_body.to_json
      Faraday.new.post do |request|
        request.url                      = 'https://onesignal.com/api/v1/notifications'
        request.headers['Content-Type']  = 'application/json;charset=utf-8'
        request.headers['Authorization'] = "Basic #{ENV['ONE_SIGNAL_REST_KEY']}"
        request.body                     = request_json
      end
    end
  end
end
