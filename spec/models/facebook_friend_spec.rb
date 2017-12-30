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
    context 'with all necessary attributes' do
      let!(:facebook_friend) { build(:facebook_friend) }

      it 'is valid' do
        expect(facebook_friend).to be_valid
      end
    end

    context 'Presence Validation' do
      let!(:facebook_friend) { build(:facebook_friend) }

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
      # TODO: let(:facebook_friend) { build(:facebook_friend) }で、テストが通らなかったため調査が必要。
      it 'is invalid with the same pair of user_id and facebook_id' do
        existing_facebook_friend = create(:facebook_friend)
        facebook_friend = FacebookFriend.new(user_id: existing_facebook_friend.user_id, facebook_id: existing_facebook_friend.facebook_id)
        expect(facebook_friend.valid?).to be_falsey
        expect(facebook_friend.errors[:user_id]).to include('has already been taken')
      end
    end

    context 'Custom Validation' do
      it 'is invalid with the pair of user_id and facebook_id of a certain user.' do
        user = create(:user)
        facebook_friend = FacebookFriend.new(user_id: user.id, facebook_id: user.facebook_id)
        expect(facebook_friend.valid?).to be_falsey
        expect(facebook_friend.errors[:user_id]).to include('The primary id of the same user was about to get inserted.')
        expect(facebook_friend.errors[:facebook_id]).to include('The facebook_id of the same user was about to get inserted.')
      end
    end
  end
end
