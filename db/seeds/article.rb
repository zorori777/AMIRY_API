# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      default(""), not null
#  content       :text(65535)      not null
#  updated_times :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

RECORD_NAME = 'articles'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    article = Article.new(
      user_id: (1..10).to_a.sample,
      title:   Faker::Onepiece.character,
      content: Faker::HowIMetYourMother.quote,
    )
    article.save! 
    p article
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{Article.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{Article.count}"
    exit
  end
end
