module APIComponents
  module Entities
    class Matching < Grape::Entity
      expose :id,          documentation: { required: true, type: 'Integer', desc: 'The primary id of the matching.' }
      expose :sender_name, documentation: { required: true, type: 'String',  desc: 'The name of the sender who sent the matching request.' }
      expose :acceptance,  documentation: { required: true, type: 'Integer', desc: 'The acceptance status of the matching.' }
      expose :created_at,  documentation: { required: true, type: 'String',  desc: 'When the matching request got sent.' }
      expose :updated_at,  documentation: { required: true, type: 'String',  desc: 'When the matching request accceptance status got updated.' }
    end
  end
end
