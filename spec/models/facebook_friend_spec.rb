# == Schema Information
#
# Table name: facebook_friends
#
#  id          :integer          not null, primary key
#  user_id     :integer          unsigned, not null
#  facebook_id :integer          default(0), unsigned, not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe FacebookFriend do
  describe 'Validation' do
    let(:facebook_friend) { build(:facebook_friend) }

    context 'with all necessary attributes' do
      it 'is valid' do
        expect(facebook_friend).to be_valid
      end
    end

    context 'Presence Validation' do
      it 'is invalid with nil user_id' do
        facebook_friend.user_id = nil
        expect(facebook_friend.valid?).to be_falsey
        expect(facebook_friend.errors[:user_id]).to include('can\'t be blank')
      end

      it 'is invalid with nil facebook_id' do
        facebook_friend.facebook_id = nil
        expect(facebook_friend.valid?).to be_falsey
        expect(facebook_friend.errors[:facebook_id]).to include('can\'t be blank')
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with the same pair of user_id and facebook_id' do
        existing_facebook_friend = create(:facebook_friend)
        facebook_friend = FacebookFriend.new(user_id: existing_facebook_friend.user_id, facebook_id: existing_facebook_friend.facebook_id)
        expect(facebook_friend.valid?).to be_falsey
        expect(facebook_friend.errors[:user_id]).to include('has already been taken')
      end
    end
  end
end
