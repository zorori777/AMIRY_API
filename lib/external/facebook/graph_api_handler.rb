require 'json'

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

    end
  end
end
