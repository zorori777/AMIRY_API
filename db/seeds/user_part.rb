# == Schema Information
#
# Table name: user_parts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  part_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'user_parts'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    user_part = UserPart.new(
      user_id: User.pluck(:id).sample,
      part_id: Part.pluck(:id).sample
    )
    user_part.save!
    p user_part
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{UserPart.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{UserPart.count}"
    exit
  end
end
