module APIComponents
  module Entities
    # Exposed properties in Notification model
    class Notification < Grape::Entity
      expose :id,                documentation: { required: true, type: 'Integer', desc: 'The primary id of the notification.' }
      expose :user_id,           documentation: { required: true, type: 'Integer', desc: 'The id of the user.' }
      expose :target_model_id,   documentation: { required: true, type: 'Integer', desc: 'The primary id of the model.' }
      expose :target_model_type, documentation: { required: true, type: 'Integer', desc: 'The type of the model. matching: 1, like: 2, introduction: 3' }
      expose :status,            documentation: { required: true, type: 'Integer', desc: 'The status of the notification.' }
      expose :created_at,        documentation: { required: true, type: 'String',  desc: 'When the notification got created.' }
    end
  end
end
