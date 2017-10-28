# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :university do
    name { Faker::University.name }
  end
end
