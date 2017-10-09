# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  article_id :integer          not null
#  content    :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleComment < ApplicationRecord
  
  # Association
  belongs_to :article
  belongs_to :user

  # Validation
  validates :content, :user_id, :article_id, presence: true
  validates :user_id, :article_id,           numericality: true 

  def created_by?(user)
    self.user_id == user.id
  end

end
