module APIComponents
  module Entities
    class University < Grape::Entity
      expose :id,                  documentation: { required: true, type: 'Integer', desc: 'The primary id.' }
      expose :name,                documentation: { required: true, type: 'String',  desc: 'The name of the university.' }
      expose :circles_num,         documentation: { required: true, type: 'Integer', desc: 'The number of circles that the university has.' }
      expose :circles_id_and_name, documentation: { required: true, type: 'Hash',    desc: 'The ids and names of circles that the university has.', is_array: true }
    end
  end
end
