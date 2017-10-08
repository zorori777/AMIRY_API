# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  description :text(65535)      not null
#  address     :string(255)      default(""), not null
#  hold_at     :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lecture < ApplicationRecord

  scope :newest, -> { where(created_at: :desc) }

  # Association
  belongs_to :user

  # Validation
  validates :user_id, :description, 
            :address, :hold_at,     presence: true
  validates :user_id,               numericality: true

end
