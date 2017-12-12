# == Schema Information
#
# Table name: introductions
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  description  :text(65535)      not null
#  acceptance   :integer          default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :introductions do
    association  :sender,    factory: :user
    association  :recipient, factory: :user
    description  { Faker::Lorem.paragraph }
    acceptance   { Introduction.acceptances.values.sample }
  end
end
