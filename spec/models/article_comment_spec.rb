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

require 'rails_helper'

describe ArticleComment do
  let(:article_comment) { build(:article_comment) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(article_comment).to be_valid
      end
    end

    context 'without all necessary attributes' do
      context 'Presence Validation' do
        it 'is invalid with nil user_id.' do
          article_comment.user_id = nil
          expect(article_comment.valid?).to be_falsey
          expect(article_comment.errors[:user_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil article_id.' do
          article_comment.article_id = nil
          expect(article_comment.valid?).to be_falsey
          expect(article_comment.errors[:article_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil content.' do
          article_comment.content = nil
          expect(article_comment.valid?).to be_falsey
          expect(article_comment.errors[:content]).to include('can\'t be blank')
        end

        it 'is invalid with empty content.' do
          article_comment.content = ''
          expect(article_comment.valid?).to be_falsey
          expect(article_comment.errors[:content]).to include('can\'t be blank')
        end
      end
    end
  end

  describe 'Instance Methods' do
    context 'Getter Methods' do
      it 'commentor_name method should return the same name of the associated circle.' do
        expect(article_comment.user.display_name).to eq article_comment.commentor_name
      end
    end

    context 'Checker Methods.' do
      it 'created_by? method should return true if the article got created by the very user.' do
        user = article_comment.user
        expect(article_comment.created_by?(user)).to be_truthy
      end
    end
  end
end
