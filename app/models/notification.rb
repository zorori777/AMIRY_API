# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  user_id           :integer          unsigned, not null
#  target_model_type :integer          default(NULL), unsigned, not null
#  target_model_id   :integer          default(0), unsigned, not null
#  body              :string(255)      default(""), not null
#  status            :integer          default(NULL), unsigned, not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notification < ApplicationRecord
  # Callback
  before_save :set_unread_status, if: :new_record?

  # Constant
  MATCHING_BODY     = 'マッチングが成立しました！'
  INTRODUCTION_BODY = '紹介文が追加されました！'

  # Pagination
  paginates_per 10

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

  # Class Methods
  class << self
    def new_matching_notification(user_id:, matching_id:)
      notification                   = self.new
      notification.user_id           = user_id
      notification.target_model_type = self.target_model_types[:matching]
      notification.target_model_id   = matching_id
      notification.body              = MATCHING_BODY
      notification
    end
  end

  # Setter Method
  def set_unread_status
    self.status = Notification.statuses[:unread]
  end
end
