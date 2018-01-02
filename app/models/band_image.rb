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
  include FileModelInterface

  # Association
  belongs_to :band

  # Uploader
  mount_uploader :name, BandImageUploader

  # Getter Method
  def image_url
    "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.name.file.filename}"
  end
end
