# == Schema Information
#
# Table name: matchings
#
#  id         :integer          not null, primary key
#  like_id    :integer          not null
#  user_id    :integer          not null
#  acceptance :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'matchings'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    matching = Matching.new(
      like_id:      Like.pluck(:id).sample,
      recipient_id: User.pluck(:id).sample,
      sender_id:    User.pluck(:id).sample
    )
    matching.save!
    p '---------------'
    Matching.column_names.each do |column|
      p "#{column}: #{matching.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Matching.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Matching.count}"
    exit
  end
end
