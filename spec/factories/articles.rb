# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      default(""), not null
#  content       :text(65535)      not null
#  updated_times :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :article do
    association   :user, factory: :user
    title         { Faker::Book.title }
    content       { Faker::HowIMetYourMother.quote }
    updated_times { Faker::Number.between(1, 10) }
  end
end



