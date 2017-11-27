module APIComponents
  module Entities
    class Band < Grape::Entity
      expose :id
      expose :circle_name
      expose :concept
      expose :description
      expose :people_num
      expose :type
      expose :united_at
      expose :intercollege_circle
    end
  end
end
