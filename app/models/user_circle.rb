# == Schema Information
#
# Table name: user_circles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  circle_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserCircle < ApplicationRecord

  # Association
  belongs_to :user
  belongs_to :circle

  # Validation
  validates :user_id, :circle_id, presence: true, numericality: true
  validates :circle_id,           uniqueness: { scope: :user_id }

  # Counter Culture
  counter_culture :user,   column_name: 'bands_count'
  counter_culture :circle, column_name: 'members_count'

end
