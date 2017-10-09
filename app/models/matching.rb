# == Schema Information
#
# Table name: matchings
#
#  id         :integer          not null, primary key
#  like_id    :integer          not null
#  user_id    :integer          not null
#  acceptance :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Matching < ApplicationRecord

  # Enum
  enum acceptance: { accepted: 1, rejected: 2 }

  # Association
  belongs_to :like
  belongs_to :user

  # Validation
  validates :user_id, :like_id, numericality: true, presence: true

  # Counter Culture
  counter_culture :user, column_name: 'matchings_count'

end
