# == Schema Information
#
# Table name: lives
#
#  id                 :integer          not null, primary key
#  circle_id          :integer          not null
#  name               :string(255)      default(""), not null
#  description        :text(65535)      not null
#  max_capacity       :integer          default(0), unsigned, not null
#  reservations_count :integer          default(0), unsigned, not null
#  type               :integer          default(NULL), unsigned, not null
#  hold_at            :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

RECORD_NAME = 'lives'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    live = Live.new(
      circle_id:   Circle.pluck(:id).sample,
      name:        Faker::Team.name,
      description: Faker::HowIMetYourMother.catch_phrase,
      hold_at:     Date.today
    )
    live.save!
    p live
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Live.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Live.count}"
    exit
  end
end
