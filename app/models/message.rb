# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  body         :string(255)      default(""), not null
#  image        :string(255)      default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ApplicationRecord
  # Association
  belongs_to :sender,    class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  # Validation
  validates :sender_id, :recipient_id, numericality: true, presence: true
  validates :body_or_image,        presence: true

  def body_or_image
    body.presence || image.presence
  end
end
