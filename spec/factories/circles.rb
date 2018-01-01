# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  university_id :integer          not null
#  name          :string(255)      default(""), not null
#  description   :string(255)      default(""), not null
#  members_count :integer          default(0), unsigned, not null
#  bands_count   :integer          default(0), unsigned, not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :circle do
    association   :university, factory: :university
    name          { Faker::Company.name  }
    description   { Faker::Pokemon.name }
    members_count { Faker::Number.between(1, 10) }
    bands_count   { Faker::Number.between(1, 10) }
  end
end
