# == Schema Information
#
# Table name: facebook_friends
#
#  id          :integer          not null, primary key
#  user_id     :integer          unsigned, not null
#  facebook_id :integer          default(0), unsigned, not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class FacebookFriend < ApplicationRecord
  # Association
  belongs_to :user

  # Validation
  validates :user_id,                         uniqueness: { scope: :facebook_id }
  validates :user_id, :facebook_id,           numericality: { only_integer: true }, presence: true
end
