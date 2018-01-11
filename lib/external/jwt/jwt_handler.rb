require 'jwt'
require 'dotenv'

Dotenv.overload

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

      def encodes
        { token: ::JWT.encode(payload, hmac_secret, HMAC_ALGORITHM) }
      end

      def user_by(token:)
        decoded_token = ::JWT.decode(token, hmac_secret, true, { algorithm: HMAC_ALGORITHM })
        user = User.find_by(facebook_id: decoded_token.first['data']['facebook_id'])
        unless user.present?
          return {
            error: {
              message: 'User Not Found', code: 404,
              detail:  'User with facebook id in JWT does not exist.',
            }
          }
        end
        user
      rescue ::JWT::ExpiredSignature
        refresh!
      rescue ::JWT::DecodeError
        {
          error: {
            message: 'Jwt Decode Error', code: 403,
            detail:  'Jwt did not get decode properly.',
          }
        }
      end

      private

      def payload
        {
          exp:  Time.now.to_i + LIFETIME_SECONDS,
          data: {
            facebook_id: @facebook_id,
            email:       @email,
            created_at:  @created_at,
          }
        }
      end

      def hmac_secret
        ENV['HMAC_SECRET']
      end

      def refresh!
        encodes
      end
    end
  end
end
