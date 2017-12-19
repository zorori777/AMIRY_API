module APIComponents
  module Entities
    class Matching < Grape::Entity
      expose :sender_name
      expose :acceptance
      expose :created_at
      expose :updated_at
    end
  end
end
