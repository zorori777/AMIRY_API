# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :integer          default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Part < ApplicationRecord
  # Enum
  enum name: { lead: 1, first_chorus: 2, second_chorus: 3, third_chorus: 4, bass: 5, percussion: 6 }

  # Association
  has_many :user_parts
  has_many :users,     through: :user_parts

  # Validation
  validates :name, uniqueness: true, presence: true
end
