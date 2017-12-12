# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  body         :string(255)      default(""), not null
#  image        :string(255)      default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :messages do
    association :sender,    factory: :user
    association :recipeint, factory: :user
    body        { Faker::HowIMetYourMother.quote }
    image       { Faker::Avatar.image("my-own-slug") }
  end
end
