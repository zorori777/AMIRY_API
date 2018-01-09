module APIComponents
  module Errors
    class InternalServerError < ErrorBase
      def initialize(message:)
        error!(
          {
            message: 'Internal Server Error', code: 500,
            detail: message,
            with: APIComponents::Entities::Error
          }, 500
        )
      end
    end
  end
end
