# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class University < ApplicationRecord

  # Constant
  PER_PAGE = 10

  # Association
  has_many :bands 
  has_many :circles

  # Validation
  validates :name, uniqueness: true, presence: true

end
