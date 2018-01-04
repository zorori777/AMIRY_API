# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  user_id           :integer          unsigned, not null
#  target_model_type :integer          default(NULL), unsigned, not null
#  target_model_id   :integer          default(0), unsigned, not null
#  body              :string(255)      default(""), not null
#  status            :integer          default(NULL), unsigned, not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryBot.define do
  factory :notification do
    random_target_model_type = Notification.target_model_types.keys.sample

    association       :user, factory: :user
    target_model_type { Notification.target_model_types[random_target_model_type] }
    target_model_id   { random_target_model_type.capitalize.constantize.pluck(:id).sample }
    body              { Faker::Pokemon.name }
    status            { Notification.statuses.values.sample }
  end
end
