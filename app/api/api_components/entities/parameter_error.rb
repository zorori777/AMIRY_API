module APIComponents
  module Entities
    class ParameterErrorContent < Grape::Entity
      expose :code,     documentation: { required: true, type: 'Integer', desc: 'HTTP status code.' }
      expose :messages, documentation: { required: true, type: JSON,      desc: 'エラーメッセージ [{ "parameter_name": ["Error messages"] }]', is_array: true }
    end

    class ParameterError < Grape::Entity
      expose :error, using: ParameterErrorContent
    end
  end
end
