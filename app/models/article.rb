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

  # Constant
  PER_PAGE = 15

  # Scope
  scope :in_newest_order, -> { order(created_at: :desc) }

  # Association
  belongs_to :user, -> { includes(:university) }
  has_many   :article_comments

  # Validation
  validates :content, :user_id, presence: true
  validates :user_id,           numericality: true

  def created_by?(user)
    self.user_id == user.id
  end
  
end
