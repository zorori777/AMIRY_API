module APIComponents
  module Entities
    class JWT < Grape::Entity
      expose :token, documentation: { required: true, type: 'String', desc: 'Token (JSON Web Token)' }
    end
  end
end
