# == Schema Information
#
# Table name: article_files
#
#  id         :integer          not null, primary key
#  user_id    :integer          unsigned, not null
#  article_id :integer          unsigned, not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleFile < ApplicationRecord
  # Mix-in
  include FileModelInterface

  # Validation
  validates :user_id, :article_id, numericality: { only_integer: true }, presence: true

  # Uploader
  mount_uploader :name, ArticleFileUploader
  
  def file_url
    "#{AMAZON_S3_DOMAIN}/#{self.s3_directory}/#{self.name.file.filename}"
  end
end
