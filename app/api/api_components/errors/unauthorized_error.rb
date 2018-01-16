module APIComponents
  module Errors
    class UnauthorizedError < ErrorBase
      def initialize(message:)
        error!(
          {
            message: 'Unauthorized', code: 401,
            detail:  message,
            with:    APIComponents::Entities::Error
          }, 401
        )
      end
    end
  end
end
