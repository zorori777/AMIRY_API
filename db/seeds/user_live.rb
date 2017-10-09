# == Schema Information
#
# Table name: user_lives
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  live_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'user_live'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    user_live = UserLive.new(
      user_id: User.pluck(:id).sample,
      live_id: Live.pluck(:id).sample
    )
    user_live.save!
    p user_live
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{UserLive.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{UserLive.count}"
    exit
  end

end
