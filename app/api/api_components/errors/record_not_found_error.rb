module APIComponents
  module Errors
    # Error thrown when an argument is missing
    class RecordNotFoundError < ErrorBase

      def initialize(id:, model:)
        error!(
            { message: 'Record Not Found', code: 404,
              detail: "#{model} with #{id} not found.",
              with: APIComponents::Entities::Error
            }, 404
        )
      end

    end
  end
end
