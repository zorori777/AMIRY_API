# == Schema Information
#
# Table name: facebook_friends
#
#  id          :integer          not null, primary key
#  user_id     :integer          unsigned, not null
#  facebook_id :integer          default(0), unsigned, not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

RECORD_NAME = 'facebook_friends'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    facebook_friend = FacebookFriend.new(
      user_id:     User.pluck(:id).sample,
      facebook_id: User.pluck(:facebook_id).sample,
    )
    facebook_friend.save!
    p '---------------'
    FacebookFriend.column_names.each do |column|
      p "#{column}: #{facebook_friend.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{FacebookFriend.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{FacebookFriend.count}"
    exit
  end
end
