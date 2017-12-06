# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  university_id             :integer          unsigned, not null
#  facebook_id               :integer          default(0), not null
#  facebook_token            :string(255)      default(""), not null
#  facebook_token_expires_at :integer          default(0), unsigned, not null
#  first_name                :string(255)      default(""), not null
#  last_name                 :string(255)      default(""), not null
#  display_name              :string(255)      default(""), not null
#  email                     :string(255)      default(""), not null
#  avatar                    :string(255)      default(""), not null
#  catch_copy                :string(255)      default(""), not null
#  self_introduction         :text(65535)      not null
#  bands_count               :integer          default(0), unsigned, not null
#  received_likes_count      :integer          default(0), unsigned, not null
#  sendable_likes_count      :integer          default(0), unsigned, not null
#  matchings_count           :integer          default(0), unsigned, not null
#  account_status            :integer          default(NULL), unsigned, not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

FactoryBot.define do
  user_object = Faker::Omniauth.facebook

  factory :user do
    association :university, factory: :university
    facebook_id               { user_object[:extra][:raw_info][:id].to_i }
    facebook_token            { user_object[:credentials][:token] }
    facebook_token_expires_at { user_object[:credentials][:expires_at] }
    first_name                { user_object[:info][:first_name] }
    last_name                 { user_object[:info][:last_name] }
    email                     { user_object[:info][:email] }
    avatar                    { user_object[:info][:image] }
    catch_copy                { Faker::HowIMetYourMother.catch_phrase }
    self_introduction         { Faker::HowIMetYourMother.quote }
    account_status            { User.account_statuses[:registered] }
  end
end
