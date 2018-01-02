# == Schema Information
#
# Table name: lecture_files
#
#  id         :integer          not null, primary key
#  user_id    :integer          unsigned, not null
#  lecture_id :integer          unsigned, not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LectureFile < ApplicationRecord
  # Mix-in
  include FileModelInterface

  # Constant
  AMAZON_S3_DOMAIN = 'https://s3-ap-northeast-1.amazonaws.com'

  # Association
  belongs_to :user
  belongs_to :lecture

  # Validation
  validates :user_id, :lecture_id, presence: true, numericality: { only_integer: true }

  # Uploader
  mount_uploader :name, LectureFileUploader

  def file_url
    "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.name.file.filename}"
  end

end
