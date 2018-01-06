module APIComponents
  module Entities
    class Like < Grape::Entity
      expose :sender_name, documentation: { required: true, type: 'String',   desc: 'The name of the sender who sent the like request.' }
      expose :acceptance,  documentation: { required: true, type: 'Integer',  desc: 'The acceptance status of like request.' }
      expose :created_at,  documentation: { required: true, type: 'Datetime', desc: 'When the like request got sent.' }
      expose :updated_at,  documentation: { required: true, type: 'Datetime', desc: 'When the like acceptance got updated.' }
    end
  end
end
