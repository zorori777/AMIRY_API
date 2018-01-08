# == Schema Information
#
# Table name: article_files
#
#  id         :integer          not null, primary key
#  user_id    :integer          unsigned, not null
#  article_id :integer          unsigned, not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :article_file do
    association :user,    factory: :user
    association :article, factory: :article
    name        { fixture_file_upload('spec/fixtures/baymax.jpeg', 'image/jpeg') }
  end
end
