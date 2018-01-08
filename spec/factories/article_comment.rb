# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  article_id :integer          not null
#  content    :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :article_comment do
    association   :user,    factory: :user
    association   :article, factory: :article
    content       { Faker::HowIMetYourMother.quote }
  end
end
