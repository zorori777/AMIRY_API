# == Schema Information
#
# Table name: user_circles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  circle_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'user_circles'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    user_circle = UserCircle.new(
      user_id:   User.pluck(:id).sample,
      circle_id: Circle.pluck(:id).sample
    )
    user_circle.save!
    p user_circle
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{UserCircle.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{UserCircle.count}"
    exit
  end

end
