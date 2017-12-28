module APIComponents
  module Entities
    # Exposed properties in Band model
    class Band < Grape::Entity
      expose :id,                  documentation: { required: true, type: 'Integer', desc: 'The primary id of the circle.' }
      expose :circle_name,         documentation: { required: true, type: 'String',  desc: 'The name of the circle that the band belongs to.' }
      expose :concept,             documentation: { required: true, type: 'String',  desc: 'The concept of the band.' }
      expose :description,         documentation: { required: true, type: 'String',  desc: 'The description of the band.' }
      expose :people_num,          documentation: { required: true, type: 'Integer', desc: 'The number of the people who belong to the band.' }
      expose :type,                documentation: { required: true, type: 'Integer', desc: 'The type of the integer.' }
      expose :united_at,           documentation: { required: true, type: 'String',  desc: 'When the band got united.' }
      expose :intercollege_circle, documentation: { required: true, type: 'Boolean', desc: 'Whether the band is intercollege or not.' }
    end
  end
end
