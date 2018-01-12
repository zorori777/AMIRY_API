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
  include FileModel

  # Association
  belongs_to :user
  belongs_to :article

  # Validation
  validates :user_id, :article_id, numericality: { only_integer: true }, presence: true

  # Uploader
  mount_uploader :name, ArticleFileUploader
end
