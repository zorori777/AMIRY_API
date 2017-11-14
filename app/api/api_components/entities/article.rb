module APIComponents
  module Entities
    class Article < Grape::Entity
      expose :id
      expose :author_name
      expose :title
      expose :content
      expose :updated_times
      expose :created_at
    end
  end
end
