# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME        = 'universities'
UNIVERSITIES_ARRAY = %w(早稲田大学 慶応大学 埼玉大学 千葉大学 東京大学 信州大学)

1.upto(UNIVERSITIES_ARRAY.size) do |num|
  begin
    university = University.new(
      name: UNIVERSITIES_ARRAY[num] 
    )
    university.save! 
    p university
    if num == UNIVERSITIES_ARRAY.size - 1
      p "#{UNIVERSITIES_ARRAY.size} records of #{RECORD_NAME} inserted. Total: #{University.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num} records have been inserted."
  end
end
