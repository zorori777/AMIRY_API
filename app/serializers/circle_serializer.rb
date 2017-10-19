# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  university_id :integer          not null
#  name          :string(255)      default(""), not null
#  description   :string(255)      default(""), not null
#  members_count :integer          default(0), unsigned, not null
#  bands_count   :integer          default(0), unsigned, not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CircleSerializer < BaseSerializer
  include ActiveModel::Serialization

  attributes :university_name, :name, :description, :members_count, :bands_count, :created_at, :updated_at

  def initialize(object, **option)
    super(object, **option)
  end

  def university_name
    object.university&.name.to_s
  end

end
