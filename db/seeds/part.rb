# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'parts'
parts = Part.names.values.sample

0.upto(parts.size) do |num|
  begin
    part = Part.new(
      name: Part.names.values[num]
    )
    part.save!
    p part
    if num == parts.size - 1
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Part.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num} records have been inserted."
    p "Total: #{Part.count}"
    exit
  end
end
