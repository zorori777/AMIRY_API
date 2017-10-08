# == Schema Information
#
# Table name: user_lives
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  live_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserLive < ApplicationRecord

  # Association
  belongs_to :user
  belongs_to :live

  # Validation
  validates :user_id, :live_id, numericality: true, presence: true

  # Counter Culture
  counter_culture :live, column_name: 'reservations_count'

end
