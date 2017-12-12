# == Schema Information
#
# Table name: lives
#
#  id                 :integer          not null, primary key
#  circle_id          :integer          not null
#  name               :string(255)      default(""), not null
#  description        :text(65535)      not null
#  max_capacity       :integer          default(0), unsigned, not null
#  reservations_count :integer          default(0), unsigned, not null
#  type               :integer          default(NULL), unsigned, not null
#  hold_at            :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryBot.define do
  factory :lives do
    association        :circle, factory: :circle
    name               { Faker::Company.name }
    description        { Faker::Lorem.paragraph }
    max_capacity       { Faker::Number.between(1, 10) }
    reservations_count { Faker::Number.between(1, 10) }
    type               { Live.types.values.sample }
    hold_at            { Faker::Time.between(2.days.ago, Date.today) }
  end
end
