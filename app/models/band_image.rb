# == Schema Information
#
# Table name: band_images
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BandImage < ApplicationRecord
  # Mix-in
  include FileModel

  # Association
  belongs_to :band

  # Uploader
  mount_uploader :name, BandImageUploader
end
