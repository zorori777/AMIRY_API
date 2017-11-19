require 'jwt'
require 'dotenv'

Dotenv.reload

module External
  module Jwt
    class JwtHandler

      HMAC_ALGORITHM = 'HS256'.freeze
      LIFETIME_SECONDS = 60 * 60 * 24 * 7

      def initialize(facebook_id:, email:, created_at:)
        @facebook_id = facebook_id
        @email       = email
        @created_at  = created_at
      end

      def encodes_jwt
        JWT.encode self.payload, self.hamc_secret_key, HMAC_ALGORITHM
      end

      private
      def payload
        {
            facebook_id: @facebook_id,
            email:       @email,
            created_at:  @created_at,
            expires_at:  Date.today.to_i + LIFETIME_SECONDS
        }
      end

      def hamc_secret
        ENV['HMAC_SECRET']
      end
    end
  end
end
