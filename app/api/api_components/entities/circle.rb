module APIComponents
  module Entities
    class Circle < Grape::Entity
      expose :id
      expose :university_name
      expose :name
      expose :description
      expose :members_count
      expose :bands_count
      expose :created_at
    end
  end
end
