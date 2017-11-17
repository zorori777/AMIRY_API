module APIComponents
  module Entities
    class User < Grape::Entity
      expose :id
      expose :university_name
      expose :first_name
      expose :last_name
      expose :display_name
      expose :email
      expose :avatar_link
      expose :catchcopy
      expose :self_introduction
      expose :bands_count
      expose :received_likes_count
      expose :sendable_likes_count
      expose :matchings_count
      expose :account_status
      expose :created_at
    end
  end
end
