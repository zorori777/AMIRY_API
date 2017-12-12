# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :integer          default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :parts do
    name { Part.names.values.sample }
  end
end
