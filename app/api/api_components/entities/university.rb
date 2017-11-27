module APIComponents
  module Entities
    class University < Grape::Entity
      expose :id
      expose :name
      expose :circles_num
    end
  end
end
