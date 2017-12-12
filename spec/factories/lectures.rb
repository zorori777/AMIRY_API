# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string(255)      default(""), not null
#  description :text(65535)      not null
#  address     :string(255)      default(""), not null
#  hold_at     :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :lectures do
    association :user,    factory: :user
    title       { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    address     { Faker::Address.street_address }
    hold_at     { Faker::Time.between(2.days.ago, Date.today) }
  end
end
