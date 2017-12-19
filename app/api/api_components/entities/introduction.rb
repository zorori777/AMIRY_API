module APIComponents
  module Entities
    class Introduction < Grape::Entity
      expose :id
      expose :sender_name
      expose :recipient_name
      expose :description
      expose :acceptance
      expose :created_at
      expose :updated_at
    end
  end
end
