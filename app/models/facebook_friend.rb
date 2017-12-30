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
  validate  :not_same_user_id_and_facebook_id

  private

  # Custom Validation
  # TODO: リファクタリング
  # 2つ目の条件文に行かせないため、わざと途中でexitしている。
  def not_same_user_id_and_facebook_id
    return unless User.find_by(id: self.user_id) || User.find_by(facebook_id: self.facebook_id)
    errors.add(:user_id, 'The user with the given id not found.')
    exit

    return unless self.facebook_id != User.find_by(id: self.user_id).facebook_id
    errors.add(:facebook_id, 'The facebook_id of the same user was about to get inserted.')
    errors.add(:user_id, 'The primary id of the same user was about to get inserted.')
  end
end
