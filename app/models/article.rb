# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord

  # scope
  scope :recent, -> { where(updated_at: :desc) }

  # Association
  belongs_to :user
  has_many   :article_comments

  # Validation
  validates :content, :user_id, presence: true
  validates :user_id,           numericality: true

  
end
