# == Schema Information
#
# Table name: user_bands
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  band_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'user_bands'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    user_band = UserBand.new(
      user_id: User.pluck(:id).sample,
      band_id: Band.pluck(:id).sample
    )
    user_band.save!
    p '---------------'
    UserBand.column_names.each do |column|
      p "#{column}: #{user_band.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Band.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Band.count}"
    exit
  end
end
