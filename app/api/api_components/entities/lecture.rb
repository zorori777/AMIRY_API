module APIComponents
  module Entities
    class Lecture < Grape::Entity
      expose :id
      expose :holder_name
      expose :title
      expose :description
      expose :address
      expose :hold_at
      expose :created_at
      expose :updated_at
    end
  end
end
