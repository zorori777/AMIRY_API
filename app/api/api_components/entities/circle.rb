module APIComponents
  module Entities
    module Circle
      class Overview < Grape::Entity
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
end
