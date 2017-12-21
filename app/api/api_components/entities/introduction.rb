module APIComponents
  module Entities
    class Introduction < Grape::Entity
      expose :id,             documentation: { required: true, type: 'Integer', desc: 'The primary id of the circle.' }
      expose :sender_name,    documentation: { required: true, type: 'String',  desc: 'The name of the user who sent the introduction.' }
      expose :recipient_name, documentation: { required: true, type: 'String',  desc: 'The name of the user who receives the introduction.' }
      expose :description,    documentation: { required: true, type: 'String',  desc: 'The description of the introduction.' }
      expose :acceptance,     documentation: { required: true, type: 'Integer', desc: 'The acceptance status of the introduction.' }
      expose :created_at,     documentation: { required: true, type: 'String',  desc: 'When the introduction got created.' }
      expose :updated_at,     documentation: { required: true, type: 'String',  desc: 'When the introduction status got updated.' }
    end
  end
end
