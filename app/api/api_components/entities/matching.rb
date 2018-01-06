module APIComponents
  module Entities
    class Matching < Grape::Entity
      expose :id,          documentation: { required: true, type: 'Integer', desc: 'The primary id of the matching.' }
      expose :sender_name, documentation: { required: true, type: 'String',  desc: 'The name of the sender who sent the like request.' }
      expose :created_at,  documentation: { required: true, type: 'String',  desc: 'When the like record got sent.' }
    end
  end
end
