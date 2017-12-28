module APIComponents
  module Entities
    # Exposed properties in Circle model
    class Circle < Grape::Entity
      expose :id,              documentation: { required: true, type: 'Integer', desc: 'The primary id of the circle.' }
      expose :university_name, documentation: { requried: true, type: 'String',  desc: 'The name of the university that the circle belongs to.' }
      expose :name,            documentation: { required: true, type: 'String',  desc: 'The name of the circle.' }
      expose :description,     documentation: { required: true, type: 'String',  desc: 'The description of the circle.' }
      expose :members_count,   documentation: { required: true, type: 'Integer', desc: 'The number of the users that belong to the circle.' }
      expose :bands_count,     documentation: { required: true, type: 'Integer', desc: 'The number of the bands that belong to the circle.' }
      expose :created_at,      documentation: { required: true, type: 'String',  desc: 'When the circle got created.' }
    end
  end
end
