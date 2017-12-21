# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  user_id           :integer          unsigned, not null
#  target_model_type :integer          default(0), unsigned, not null
#  target_model_id   :integer          default(0), unsigned, not null
#  body              :string(255)      default(""), not null
#  status            :integer          default(0), unsigned, not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notification < ApplicationRecord

  # Enum
  enum status:            { read: 1, unread: 2 }
  enum target_model_type: { matching: 1, like: 2, introduction: 3 }

  # Association
  belongs_to :user

  # Validation
  validates :body,              presence: true
  validates :user_id, :status,
            :target_model_type,
            :target_model_id,   presence: true, numericality: { only_integer: true }

end
