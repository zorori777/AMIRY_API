module APIComponents
  module Entities
    # # Exposed properties in Error model
    class ErrorContent < Grape::Entity
      expose :code,    documentation: { required: true,  type: 'Integer', desc: 'Error code' }
      expose :message, documentation: { required: true, type: 'String', desc: 'エラーメッセージ' }
    end

    # Entity for error response
    class Error < Grape::Entity
      expose :error, using: ErrorContent
    end
  end
end
