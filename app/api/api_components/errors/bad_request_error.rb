module APIComponents
  module Errors
    class BadRequestError < ErrorBase
      def initialize(message:)
        error!(
          {
            message: 'Bad Request', code: 404,
            detail: message,
            with: APIComponents::Entities::Error
          }, 404
        )
      end
    end
  end
end
