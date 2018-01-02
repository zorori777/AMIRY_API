# == Schema Information
#
# Table name: circle_images
#
#  id         :integer          not null, primary key
#  circle_id  :integer          not null
#  name       :string(255)      default(""), not null
#  type       :integer          default(NULL), unsigned, not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CircleImage < ApplicationRecord
  # Mix-in
  include FileModelInterface

  # Needs this line because the table has a column named "type"
  self.inheritance_column = :_type_disabled

  # Enum
  enum type: { logo: 1, others: 2 }

  # Association
  belongs_to :circle

  # Uploader
  mount_uploaders :name, CircleImageUploader

  def file_url
    "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.name.file.filename}"
  end
end
