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
  before_save :set_description_empty, if: :new_record?

  # Pagination
  paginates_per 10

  # Scope
  scope :recent, -> { order(created_at: :desc) }
  scope :passed, -> { where("created_at < ?", Date.today)}

  # Association
  belongs_to :user

  # Validation
  validates :user_id, :description, 
            :address, :hold_at,     presence: true
  validates :user_id,               numericality: true

  # Getter Methods
  def holder_name
    self.user&.display_name.to_s
  end

  # Setter Methods
  def set_description_empty
    self.description = '' if self.description.blank?
  end
end
