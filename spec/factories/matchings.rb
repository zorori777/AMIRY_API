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

FactoryBot.define do
  factory :matching do
    association :like,      factory: :live
    association :sender,    factory: :user
    association :recipeint, factory: :user
    acceptance  { Matching.acceptances.values.sample }
  end
end
