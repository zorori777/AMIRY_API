# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  sender_id    :integer          unsigned, not null
#  recipient_id :integer          unsigned, not null
#  acceptance   :integer          unsigned, not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :like do
    association :sender,    factory: :user
    association :recipient, factory: :user
    acceptance  { Like.acceptances.values.sample }
  end
end
