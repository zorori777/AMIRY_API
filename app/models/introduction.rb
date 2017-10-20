# == Schema Information
#
# Table name: introductions
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  description  :text(65535)      not null
#  acceptance   :integer          default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Introduction < ApplicationRecord

  # Constant
  PER_PAGE = 7

  # Enum
  enum acceptance: { accepted: 1, rejected: 99 }

  # Validation
  validates :sender_id, :recipient_id, numericality: true, presence: true
  validates :sender_id, :recipient_id, 
            :acceptance, :description, presence: true
  validates :sender_id,                uniqueness: { scope: :recipient_id }

  # Association
  belongs_to :sender,    class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

end
