
class BaseSerializer < ActiveModel::Serializer
  include ActiveModel::Serialization

  def initialize(object, **option)
    super
  end
end
