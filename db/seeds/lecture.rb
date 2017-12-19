# == Schema Information
#
# Table name: lectures
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  description :text(65535)      not null
#  address     :string(255)      default(""), not null
#  hold_at     :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

RECORD_NAME = 'lectures'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    lecture = Lecture.new(
      user_id:     User.pluck(:id).sample,
      title:       Faker::HowIMetYourMother.character,
      description: Faker::HowIMetYourMother.quote,
      address:     Faker::Address.street_address,
      hold_at:     Date.today
    )
    lecture.save!
    p "---------------"
    Lecture.column_names.each do |column|
      p "#{column}: #{lecture.send(column)}"
    end
    p "---------------"
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Lecture.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Lecture.count}"
    exit
  end
end
