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
  validates :user_id, :like_id, numericality: true, presence: true

  # Counter Culture
  counter_culture :user, column_name: 'matchings_count'

end
