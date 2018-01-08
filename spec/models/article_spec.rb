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

require 'rails_helper'

describe Article do
  let(:article) { build(:article) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(article).to be_valid
      end
    end

    context 'without all necessary attributes' do
      context 'Presence Validation' do
        it 'is invalid with nil title.' do
          article.title = nil
          expect(article.valid?).to be_falsey
          expect(article.errors[:title]).to include('can\'t be blank')
        end

        it 'is invalid with empty title.' do
          article.title = ''
          expect(article.valid?).to be_falsey
          expect(article.errors[:title]).to include('can\'t be blank')
        end

        it 'is invalid with nil content.' do
          article.content = nil
          expect(article.valid?).to be_falsey
          expect(article.errors[:content]).to include('can\'t be blank')
        end

        it 'is invalid with empty concept.' do
          article.content = ''
          expect(article.valid?).to be_falsey
          expect(article.errors[:content]).to include('can\'t be blank')
        end

        it 'is invalid with nil user_id.' do
          article.user_id = nil
          expect(article.valid?).to be_falsey
          expect(article.errors[:user_id]).to include('can\'t be blank')
        end

        it 'is invalid with updated_times.' do
          article.updated_times = nil
          expect(article.valid?).to be_falsey
          expect(article.errors[:updated_times]).to include('can\'t be blank')
        end
      end

      context 'Uniqueness Validation.' do
        it 'is invalid with the name that has already been taken in the same circle.' do
          first_article = create(:article)
          second_article = build(:article, title: first_article.title)
          expect(second_article.valid?).to be_falsey
          expect(second_article.errors[:title]).to include('has already been taken')
        end
      end
    end
  end

  describe 'Instance Methods' do
    let(:additional_article_files_num) { 3 }
    let(:article_with_article_files)   { build(:article, :with_article_files, default_article_files_num: additional_article_files_num) }

    context 'Getter Methods' do
      it 'author_name method should return the same name of the associated circle.' do
        expect(article.user.display_name).to eq article.author_name
      end

      it 'file_urls method should return the name of the files associated with the article.' do
        files = article_with_article_files.article_files
        expect(article_with_article_files.file_urls).to include files[0].file_url
      end
    end

    context 'Setter Methods.' do
      it 'set_emtpy_string_in_blank_description method should set empty string if description is empty.' do
        expect{ article.run_callbacks :update }.to change{ article.updated_times }.by(1)
      end
    end

    context 'Checker Methods.' do
      it 'created_by? method should return true if the article got created by the very user.' do
        user = article.user
        expect(article.created_by?(user)).to be_truthy
      end
    end
  end
end
