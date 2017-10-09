# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  body         :string(255)      default("NO BOBY"), not null
#  image        :string(255)      default("NO IMAGE"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

RECORD_NAME = 'messages'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    message = Message.new(
      sender_id:    User.pluck(:id).sample,
      recipient_id: User.pluck(:id).sample,
      body:         Faker::HowIMetYourMother.quote
    )
    message.save! 
    p message
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Message.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Message.count}"
    exit
  end
end
