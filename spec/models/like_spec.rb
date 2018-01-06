# == Schema Information
#
# Table name: matchings
#
#  id           :integer          not null, primary key
#  like_id      :integer          unsigned, not null
#  sender_id    :integer          unsigned, not null
#  recipient_id :integer          unsigned, not null
#  acceptance   :integer          unsigned, not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Matching do
  let(:like) { build(:like) }

  describe 'Validations' do
    context 'with all necessary attributes.' do
      it 'is valid' do
        expect(like).to be_valid
      end
    end

    context 'Presence Validation.' do
      context 'without all necessary attributes.' do
        it 'is invalid with nil sender_id.' do
          like.sender_id = nil
          expect(like.valid?).to be_falsey
          expect(like.errors[:sender_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil recipient_id.' do
          like.recipient_id = nil
          expect(like.valid?).to be_falsey
          expect(like.errors[:recipient_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil acceptance.' do
          like.acceptance = nil
          expect(like.valid?).to be_falsey
          expect(like.errors[:acceptance]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with the same pair of sender_id and recipient_id' do
        existing_like = create(:like)
        like.sender_id = existing_like.sender_id
        like.recipient_id = existing_like.recipient_id
        expect(like.valid?).to be_falsey
        expect(like.errors[:sender_id]).to include('has already been taken')
      end
    end

    context 'Getter Methods' do
      it 'sender_name method should return the display_name of the associated sender.' do
        expect(like.sender_name).to eq like.sender.display_name
      end

      it 'recipient_name method should return the display_name of the associated recipient.' do
        expect(like.recipient_name).to eq like.recipient.display_name
      end
    end

    context 'Setter Methods.' do
      it 'update_acceptance_status! method should update the data of acceptance.' do
        existing_like = create(:like)
        previous_acceptance = existing_like.acceptance
        desired_acceptance = (Like.acceptances.values - [existing_like.acceptance_before_type_cast]).sample
        existing_like.update_acceptance!(acceptance: desired_acceptance)
        expect(existing_like.acceptance).not_to eq previous_acceptance
      end
    end
  end
end
