# == Schema Information
#
# Table name: facebook_friends
#
#  id          :integer          not null, primary key
#  user_id     :integer          unsigned, not null
#  facebook_id :integer          default(0), unsigned, not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :facebook_friend do
    association :user, factory: :user
    facebook_id { Faker::Omniauth.facebook[:extra][:raw_info][:id].to_i }
  end
end
