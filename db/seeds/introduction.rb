# == Schema Information
#
# Table name: introductions
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  description  :text(65535)      not null
#  acceptance   :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

RECORD_NAME = 'introductions'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    introduction = Introduction.new(
      sender_id:    User.pluck(:id).sample,
      recipient_id: User.pluck(:id).sample,
      description:  Faker::HowIMetYourMother.quote,
      acceptance:   Introduction.acceptances.values.sample
    )
    introduction.save!
    p '---------------'
    Introduction.column_names.each do |column|
      p "#{column}: #{introduction.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Introduction.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Introduction.count}"
    exit
  end
end
