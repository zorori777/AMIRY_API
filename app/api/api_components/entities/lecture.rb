module APIComponents
  module Entities
    # Exposed properties in Lecture model
    class Lecture < Grape::Entity
      expose :id,          documentation: { required: true, type: 'Integer', desc: 'The primary id of the circle.' }
      expose :holder_name, documentation: { required: true, type: 'String',  desc: 'The name of the user who holds.' }
      expose :title,       documentation: { required: true, type: 'String',  desc: 'The title of the lecture.' }
      expose :description, documentation: { required: true, type: 'String',  desc: 'The description of the lecture.' }
      expose :address,     documentation: { required: true, type: 'String',  desc: 'The address of the lecture.' }
      expose :hold_at,     documentation: { required: true, type: 'String',  desc: 'When the lecture is to be held.' }
      expose :created_at,  documentation: { required: true, type: 'String',  desc: 'When the lecture got created.' }
    end
  end
end
