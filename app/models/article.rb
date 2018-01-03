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
  # Pagination
  paginates_per 15

  # Scope
  scope :in_newest_order, -> { order(created_at: :desc) }

  # Association
  belongs_to :user
  has_many   :article_comments
  has_many   :article_files

  # Validation
  validates :title, :content,
            :user_id,         presence: true
  validates :user_id,         numericality: { only_integer: true }

  # Getter Methods
  def author_name
    self.user&.display_name.to_s
  end

  def file_urls
    self.article_files.map(&:file_url)
  end

  # Checker Methods
  def created_by?(user)
    self.user_id == user.id
  end
end
