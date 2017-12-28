# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  university_id :integer          not null
#  name          :string(255)      default(""), not null
#  description   :string(255)      default(""), not null
#  members_count :integer          default(0), unsigned, not null
#  bands_count   :integer          default(0), unsigned, not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

RECORD_NAME = 'circles'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    circle = Circle.new(
      university_id: University.pluck(:id).sample,
      name:          Faker::Company.name,
      description:   Faker::Lorem.sentence
    )
    circle.save!
    p circle
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Circle.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Circle.count}"
    exit
  end
end
