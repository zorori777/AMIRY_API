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

class Circle < ApplicationRecord
  # Pagination
  paginates_per 15

  # Association
  has_many   :bands
  has_many   :circle_images
  has_many   :user_circles
  has_many   :circles,      through: :user_circles
  belongs_to :university

  # Validation
  validates :name, :description,
            :members_count, :bands_count,   presence: true
  validates :bands_count,
            :members_count, :university_id, numericality: { only_integer: true }
  validates :name,                          uniqueness: { scope: :university_id }

  # Getter method
  def university_name
    self.university&.name.to_s
  end
end
