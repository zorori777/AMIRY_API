# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      default(""), not null
#  content       :text(65535)      not null
#  updated_times :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Article < ApplicationRecord

  # Constant
  paginates_per 15

  # Scope
  scope :in_newest_order, -> { order(created_at: :desc) }

  # Association
  belongs_to :user, optional: true
  has_many   :article_comments

  # Validation
  validates :content, :user_id, presence: true
  validates :user_id,           numericality: true

  def created_by?(user)
    self.user_id == user.id
  end

  def author_name
    self.user&.display_name.to_s
  end
  
end
