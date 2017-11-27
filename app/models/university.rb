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

  # Pagination
  paginates_per 15

  # Association
  has_many :circles
  has_many :users

  # Validation
  validates :name, uniqueness: true, presence: true

  # Getter methods
  def circles_num
    self.circles.size
  end

end
