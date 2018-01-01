# == Schema Information
#
# Table name: bands
#
#  id          :integer          not null, primary key
#  circle_id   :integer          not null
#  name        :string(255)      default(""), not null
#  concept     :string(255)      default(""), not null
#  description :text(65535)      not null
#  people_num  :integer          default(0), unsigned, not null
#  type        :integer          default(NULL), unsigned, not null
#  united_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :band do
    association :circle, factory: :circle
    name        { Faker::Pokemon.name  }
    concept     { Faker::HowIMetYourMother.quote }
    description { Faker::Number.between(1, 10) }
    people_num  { Faker::Number.between(Band::MIX_NUM, Band::MIX_NUM) }
    type        { Band.types.values.sample }
    united_at   { Date.today }
  end
end
