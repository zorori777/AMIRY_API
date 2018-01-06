# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

RECORD_NAME = 'likes'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    like = Like.new(
      sender_id:    User.pluck(:id).sample,
      recipient_id: User.pluck(:id).sample,
      acceptance:   Like.acceptances.values.sample
    )
    like.save!
    p '---------------'
    Like.column_names.each do |column|
      p "#{column}: #{matching.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Like.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Like.count}"
    exit
  end
end
