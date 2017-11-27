module APIComponents
  module Entities
    class Live < Grape::Entity
      expose :id
      expose :circle_name
      expose :description
      expose :max_capacity
      expose :reservations_count
      expose :type
      expose :hold_at
      expose :created_at
      expose :available_seats
    end
  end
end
