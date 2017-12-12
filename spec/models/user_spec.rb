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

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'Presence Validation' do
      context 'without all necessary attributes' do
        it 'is invalid with nil first_name' do
          user.first_name = nil
          expect(user.valid?).to be_falsey
          expect(user.errors[:first_name]).to include('can\'t be blank')
        end

        it 'is invalid with empty first_name' do
          user.first_name = ''
          expect(user.valid?).to be_falsey
          expect(user.errors[:first_name]).to include('can\'t be blank')
        end

        it 'is invalid with nil last_name' do
          user.last_name = nil
          expect(user.valid?).to be_falsey
          expect(user.errors[:last_name]).to include('can\'t be blank')
        end

        it 'is invalid with empty last_name' do
          user.last_name = ''
          expect(user.valid?).to be_falsey
          expect(user.errors[:last_name]).to include('can\'t be blank')
        end

        it 'is invalid with nil email' do
          user.email = nil
          expect(user.valid?).to be_falsey
          expect(user.errors[:email]).to include('can\'t be blank')
        end

        it 'is invalid with empty email' do
          user.email = ''
          expect(user.valid?).to be_falsey
          expect(user.errors[:email]).to include('can\'t be blank')
        end

        it 'is invalid with empty email' do
          user.email = ''
          expect(user.valid?).to be_falsey
          expect(user.errors[:email]).to include('can\'t be blank')
        end

        it 'is invalid with nil facebook_id' do
          user.facebook_id = nil
          expect(user.valid?).to be_falsey
          expect(user.errors[:facebook_id]).to include('can\'t be blank')
        end

        it 'is invalid with empty facebook_id' do
          user.facebook_id = ''
          expect(user.valid?).to be_falsey
          expect(user.errors[:facebook_id]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with the email that has already been taken.' do
        existing_user = create(:user)
        user.email = existing_user.email
        expect(user.valid?).to be_falsey
        expect(user.errors[:email]).to include('has already been taken')
      end

      it 'is invalid with the facebook_id that has already been taken.' do
        existing_user = create(:user)
        user.facebook_id = existing_user.facebook_id
        expect(user.valid?).to be_falsey
        expect(user.errors[:facebook_id]).to include('has already been taken')
      end
    end
  end
end
