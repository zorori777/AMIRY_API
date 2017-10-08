# == Schema Information
#
# Table name: band_lives
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  live_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BandLive < ApplicationRecord

  # Association
  belongs_to :band
  belongs_to :live

  # Validation
  validates :band_id, :live_id, numericality: true
  
end
