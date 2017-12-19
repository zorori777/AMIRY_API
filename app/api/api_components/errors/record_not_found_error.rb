module APIComponents
  module Errors
    class RecordNotFoundError < ErrorBase
      def initialize(id:, model:)
        error!(
            {
              message: 'Record Not Found', code: 404,
              detail: "#{model} with #{id} not found.",
              with: APIComponents::Entities::Error
            }, 404
        )
      end
    end
  end
end
