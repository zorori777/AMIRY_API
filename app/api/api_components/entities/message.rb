module APIComponents
  module Entities
    class Message < Grape::Entity
      expose :sender_name,    documentation: { required: true, type: String, desc: 'The display name of the sender.' }
      expose :recipient_name, documentation: { required: true, type: String, desc: 'The display name of the recipient.' }
      expose :body,           documentation: { required: true, type: String, desc: 'The body of the message.' }
      expose :file_url,       documentation: { required: true, type: String, desc: 'The image of the messsage.' }
      expose :created_at,     documentation: { required: true, type: String, desc: 'When the message got sent.' }
    end
  end
end
