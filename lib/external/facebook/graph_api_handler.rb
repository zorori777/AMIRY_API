require 'json'
require 'time'
require 'dotenv'

Dotenv.overload

module External
  module Facebook
    class GraphApiHandler
      attr_accessor :facebook_token, :id_on_facebook

      FACEBOOK_GRAPH_API_URL = 'https://graph.facebook.com'
      DEBUG_TOKEN_ENDPOINT   = 'debug_token'

      def initialize(facebook_token:, facebook_id:)
        @facebook_id    = facebook_id
        @facebook_token = facebook_token

        debug_token_response      = Faraday.get "#{FACEBOOK_GRAPH_API_URL}/#{DEBUG_TOKEN_ENDPOINT}", { input_token: @facebook_token, access_token: ENV['FACEBOOK_APP_ACCESS_TOKEN'] }
        @debug_token_response     = JSON.parse(debug_token_response.body)

        me_endpoint_response      = Faraday.get "#{FACEBOOK_GRAPH_API_URL}/#{@facebook_id}", { access_token: ENV['FACEBOOK_APP_ACCESS_TOKEN'], fields: 'email,first_name,last_name,name' }
        @me_endpoint_response     = JSON.parse(me_endpoint_response.body)

        friend_endpoint_response  = Faraday.get "#{FACEBOOK_GRAPH_API_URL}/#{@facebook_id}/friends", { access_token: ENV['FACEBOOK_APP_ACCESS_TOKEN'] }
        @friend_endpoint_response = JSON.parse(friend_endpoint_response.body)
      end

      def valid_facebook_id_and_token?
        valid_app_id? && valid_facebook_id? && valid_facebook_token?
      end

      def valid_app_id?
        return false unless @debug_token_response['data']['app_id'].present?
        ENV['FACEBOOK_APP_ID'] == @debug_token_response['data']['app_id']
      end

      def valid_facebook_id?
        return false unless @debug_token_response['data']['user_id'].present?
        @facebook_id == @debug_token_response['data']['user_id']
      end

      def valid_facebook_token?
        return false unless @debug_token_response['data']['expires_at'].present?
        Time.now.to_i <= @debug_token_response['data']['expires_at']
      end

      def facebook_friends
        @friend_endpoint_response['data']
      end

      def facebook_friends_num
        @friend_endpoint_response['summary']['total_count'] || 0
      end

      def first_name
        @me_endpoint_response['first_name']
      end

      def last_name
        @me_endpoint_response['last_name']
      end

      def email
        @me_endpoint_response['email']
      end

      def facebook_id
        @me_endpoint_response['id']
      end
    end
  end
end
