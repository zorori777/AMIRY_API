module APIComponents
  module Errors
    class UnauthorizedError < ErrorBase
      def initialize(detail:)
        error!(
          {
            message: 'Unauthorized', code: 401,
            detail: detail,
            with: APIComponents::Entities::Error
          }, 401
        )
      end
    end
  end
end
