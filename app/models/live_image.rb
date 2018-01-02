# == Schema Information
#
# Table name: live_images
#
#  id         :integer          not null, primary key
#  live_id    :integer          not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LiveImage < ApplicationRecord
  # Mix-in
  include FileModelInterface

  # Constant
  AMAZON_S3_DOMAIN = 'https://s3-ap-northeast-1.amazonaws.com'

  # Association
  belongs_to :live

  # Uploader
  mount_uploader :name, LiveImageUploader

  # Getter Methods
  def file_url
    "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.name.file.filename}"
  end
end
