# == Schema Information
#
# Table name: user_parts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  part_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserPart < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :part

  # Validations
  validates :user_id, :part_id, numericality: { only_integer: true }
end
