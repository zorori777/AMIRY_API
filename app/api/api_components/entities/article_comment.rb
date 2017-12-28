module APIComponents
  module Entities
    # Exposed properties in ArticleComment model
    class ArticleComment < Grape::Entity
      expose :id,             documentation: { required: true, type: 'Integer', desc: 'The primary id of the article.' }
      expose :commentor_name, documentation: { required: true, type: 'String',  desc: 'The name of the user who has added the comment.' }
      expose :content,        documentation: { required: true, type: 'String',  desc: 'The content of the article comment.' }
      expose :created_at,     documentation: { required: true, type: 'String',  desc: 'When the article comment got created.' }
    end
  end
end
