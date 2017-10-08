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
  belongs_to :live
  belongs_to :user

  # Validation
  validates :user_id, :live_id, numericality: true, presence: true

end
