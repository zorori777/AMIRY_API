# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleSerializer < BaseSerializer
  include ActiveModel::Serialization

  attributes :content, :created_at, :updated_at, :user

  def initialize(decorated_object, **option)
    @serialized_object = decorated_object.object
    super(@serialized_object, user_object: @serialized_object.user, **option)
  end

  def user
    user_format_json
  end
end
