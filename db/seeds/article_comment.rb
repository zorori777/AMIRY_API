# == Schema Information
#
# Table name: article_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  article_id :integer          not null
#  content    :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RECORD_NAME = 'article_comments'
DUMMY_REPEAT_TIMES = 20

1.upto(DUMMY_REPEAT_TIMES) do |num|
  begin
    article_comment = ArticleComment.new(
      user_id: User.pluck(:id).sample,
      article_id: Article.pluck(:id).sample,
      content: Faker::HowIMetYourMother.quote
    )
    article_comment.save!
    p article_comment
    if num == DUMMY_REPEAT_TIMES
      p "#{num} records of #{RECORD_NAME} inserted. Total: #{ArticleComment.count}"
    end
  rescue => error
    p "Seed file fails because #{error.message}. #{num - 1} records have been inserted."
    p "Total: #{ArticleComment.count}"
    exit
  end
end
