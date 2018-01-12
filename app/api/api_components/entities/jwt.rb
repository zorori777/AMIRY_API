module APIComponents
  module Entities
    class Jwt < Grape::Entity
      expose :token, documentation: { required: true, type: 'String', desc: 'Token (JSON Web Token)' }
    end
  end
end
