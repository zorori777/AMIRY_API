module APIComponents
  module Entities
    class ArticleComment < Grape::Entity
      expose :id
      expose :commenter_name
      expose :content
      expose :created_at
      expose :updated_at
    end
  end
end
