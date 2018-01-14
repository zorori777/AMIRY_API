# == Schema Information
#
# Table name: user_bands
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  band_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserBand < ApplicationRecord
  # Validation
  validates :user_id, :band_id, presence: true, numericality: { only_integer: true }

  # Association
  belongs_to :user
  belongs_to :band

  # Counter culture
  counter_culture :band, column_name: 'people_num'
end
