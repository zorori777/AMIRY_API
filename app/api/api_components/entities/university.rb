module APIComponents
  module Entities
    class University < Grape::Entity
      expose :id
      expose :name
      expose :circles_num
      expose :circles_id_and_name
    end
  end
end
