# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string(255)      default(""), not null
#  description :text(65535)      not null
#  address     :string(255)      default(""), not null
#  hold_at     :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lecture < ApplicationRecord
  # Callback Methods
  before_save :set_empty_string_in_blank_description, if: :new_record?

  # Pagination
  paginates_per 10

  # Scope
  scope :in_newest_order, -> { order(created_at: :desc) }
  scope :without_passed,  -> { where('created_at < ?', Date.today) }

  # Association
  belongs_to :user
  has_many   :lecture_files

  # Validation
  validates :user_id, :title,
            :description, :address,
            :hold_at,               presence: true
  validates :user_id,               numericality: { only_integer: true }

  # Getter Methods
  def holder_name
    self.user&.display_name.to_s
  end

  def file_urls
    self.lecture_files.map(&:file_url)
  end

  # Setter Methods
  def set_empty_string_in_blank_description
    self.description = '' if self.description.blank?
  end
end
