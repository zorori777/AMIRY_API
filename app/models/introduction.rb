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
  # Callback
  before_save :set_acceptance_pending, if: :new_record?

  # Pagination
  paginates_per 7

  # Enum
  enum acceptance: { accepted: 1, pending: 2, rejected: 3 }

  # Validation
  validates :sender_id, :recipient_id,         numericality: true, presence: true
  validates :sender_id, :recipient_id, 
            :acceptance, :description,         presence: true
  validates :sender_id,                        uniqueness: { scope: :recipient_id }
  validate  :different_sender_and_recipient_id

  # Association
  belongs_to :sender,    class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  # Getter methods
  def sender_name
    self.sender&.display_name.to_s
  end

  def recipient_name
    self.recipient&.display_name.to_s
  end

  # Setter Methods
  def set_acceptance_pending
    self.acceptance = Introduction.acceptances[:pending]
  end

  # Custom Validation
  def different_sender_and_recipient_id
    if self.sender_id == self.recipient_id
      errors.add('sender_id', 'sender_id should not be the same as recipient_id.')
      errors.add('recipient_id', 'recipient_id should not be the same as sender_id.')
    end
  end
end
