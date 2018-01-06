# == Schema Information
#
# Table name: matchings
#
#  id           :integer          not null, primary key
#  like_id      :integer          unsigned, not null
#  sender_id    :integer          unsigned, not null
#  recipient_id :integer          unsigned, not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :matching do
    association :like,      factory: :like
    association :sender,    factory: :user
    association :recipient, factory: :user
  end
end
