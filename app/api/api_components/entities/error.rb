module APIComponents
  module Entities
    class Error < Grape::Entity
      expose :error do
        expose :message, documentation: { required: true, type: 'String',  desc: 'Error Message.' }
        expose :code,    documentation: { required: true, type: 'Integer', desc: 'Error code' }
        expose :detail,  documentation: { required: true, type: 'String',  desc: 'Detailed message, will be output only in development environment' }
      end
    end
  end
end
