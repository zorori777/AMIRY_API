# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  university_id             :integer          unsigned, not null
#  facebook_id               :integer          default(0), not null
#  facebook_token            :string(255)      default(""), not null
#  facebook_token_expires_at :integer          default(0), unsigned, not null
#  first_name                :string(255)      default(""), not null
#  last_name                 :string(255)      default(""), not null
#  display_name              :string(255)      default(""), not null
#  email                     :string(255)      default(""), not null
#  avatar                    :string(255)      default(""), not null
#  catch_copy                :string(255)      default(""), not null
#  self_introduction         :text(65535)      not null
#  bands_count               :integer          default(0), unsigned, not null
#  received_likes_count      :integer          default(0), unsigned, not null
#  sendable_likes_count      :integer          default(0), unsigned, not null
#  matchings_count           :integer          default(0), unsigned, not null
#  account_status            :integer          default(NULL), unsigned, not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

RECORD_NAME = 'users'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  first_name = Faker::Name.first_name

  begin
    user = User.new(
      university_id:     University.pluck(:id).sample,
      facebook_id:       Faker::Omniauth.facebook[:extra][:raw_info][:id],
      facebook_token:    Faker::Omniauth.facebook[:credentials][:token],
      first_name:        first_name,
      last_name:         Faker::Name.last_name,
      catch_copy:        Faker::StarWars.quote,
      self_introduction: Faker::Lorem.sentence,
      email:             Faker::Internet.email(first_name)
    )
    user.save!
    p '---------------'
    User.column_names.each do |column|
      p "#{column}: #{user.send(column)}"
    end
    p '---------------'
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{User.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{User.count}"
    exit
  end
end
