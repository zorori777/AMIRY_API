# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  university_id          :integer          not null
#  first_name             :string(255)      default(""), not null
#  last_name              :string(255)      default(""), not null
#  avatar                 :string(255)      default(""), not null
#  catchcopy              :string(255)      default(""), not null
#  self_introduction      :text(65535)      not null
#  bands_count            :integer          default(0), not null
#  likes_count            :integer          default(0), not null
#  mathcings_count        :integer          default(0), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

RECORD_NAME = 'users'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  first_name = Faker::Name.first_name

  begin
    user = User.new(
      university_id:     University.pluck(:id).sample,
      first_name:        first_name,
      last_name:         Faker::Name.last_name, 
      catchcopy:         Faker::StarWars.quote,
      self_introduction: Faker::Lorem.sentence,
      email:             Faker::Internet.email(first_name),
      password:          Faker::Internet.password(10, 20),
    )
    user.save!
    p user
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{User.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{User.count}"
    exit
  end
end


