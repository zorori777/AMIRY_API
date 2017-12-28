# == Schema Information
#
# Table name: bands
#
#  id          :integer          not null, primary key
#  circle_id   :integer          not null
#  name        :string(255)      default(""), not null
#  concept     :string(255)      default(""), not null
#  description :text(65535)      not null
#  people_num  :integer          default(0), unsigned, not null
#  type        :integer          default(NULL), unsigned, not null
#  united_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

RECORD_NAME = 'bands'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    band = Band.new(
      circle_id:   Circle.pluck(:id).sample,
      name:        Faker::Team.name,
      concept:     Faker::Company.catch_phrase,
      description: Faker::Lorem.sentence,
      people_num:  Faker::Number.between(4, 7),
      type:        Faker::Number.between(1, 5),
      united_at:   Date.today
    )
    band.save!
    p band
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Band.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Band.count}"
    exit
  end
end
