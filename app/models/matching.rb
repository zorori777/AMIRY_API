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
  # Pagination
  paginates_per 15

  # Enum
  enum acceptance: { accepted: 1, pending: 2, rejected: 3 }

  # Association
  belongs_to :like
  belongs_to :sender,    foreign_key: 'sender_id',    class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'

  # Validation
  validates :sender_id, :recipient_id,
            :like_id, :acceptance,     numericality: { only_integer: true }, presence: true
  validates :sender_id,                uniqueness: { scope: :recipient_id }

  # Counter Culture
  counter_culture :recipient, column_name: 'matchings_count'

  # Getter Methods
  def sender_name
    self.sender&.display_name.to_s
  end

  def recipient_name
    self.recipient&.display_name.to_s
  end
end
