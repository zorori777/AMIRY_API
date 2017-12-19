# == Schema Information
#
# Table name: matchings
#
#  id           :integer          not null, primary key
#  like_id      :integer          unsigned, not null
#  sender_id    :integer          unsigned, not null
#  recipient_id :integer          unsigned, not null
#  acceptance   :integer          unsigned, not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Matching < ApplicationRecord

  # Constant
  PER_PAGE = 15

  # Enum
  enum acceptance: { accepted: 1, rejected: 2 }

  # Association
  belongs_to :like
  belongs_to :sender,    foreign_key: 'sender_id',    class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'

  # Validation
  validates :sender_id, :recipient_id, :like_id, numericality: true, presence: true
  validates :sender_id,                          uniqueness: { scope: :recipient_id }

  # Counter Culture
  counter_culture :recipient, column_name: 'matchings_count'

  def sender_name
    self.sender&.display_name.to_s
  end

  def recipient_name
    self.recipient&.&display_name.to_s
  end

end
