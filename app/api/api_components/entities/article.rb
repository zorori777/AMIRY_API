module APIComponents
  module Entities
    class Article < Grape::Entity
      expose :id,            documentation: { required: true, type: 'Integer', desc: 'The primary id of the article.' }
      expose :author_name,   documentation: { required: true, type: 'String',  desc: 'The name of the author.' }
      expose :title,         documentation: { required: true, type: 'String',  desc: 'The title of the article.' }
      expose :content,       documentation: { required: true, type: 'String',  desc: 'The content of the article.' }
      expose :updated_times, documentation: { required: true, type: 'Integer', desc: 'The times that the user updated the article.' }
      expose :created_at,    documentation: { required: true, type: 'String',  desc: 'When the aritcle got created.' }
    end
  end
end
