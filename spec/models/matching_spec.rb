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
  let(:matching) { build(:matching) }

  describe 'Validations' do
    context 'with all necessary attributes.' do
      it 'is valid' do
        expect(matching).to be_valid
      end
    end

    context 'Presence Validation.' do
      context 'without all necessary attributes.' do
        it 'is invalid with nil like_id.' do
          matching.like_id = nil
          expect(matching.valid?).to be_falsey
          expect(matching.errors[:like_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil sender_id.' do
          matching.sender_id = nil
          expect(matching.valid?).to be_falsey
          expect(matching.errors[:sender_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil recipient_id.' do
          matching.recipient_id = nil
          expect(matching.valid?).to be_falsey
          expect(matching.errors[:recipient_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil acceptance.' do
          matching.acceptance = nil
          expect(matching.valid?).to be_falsey
          expect(matching.errors[:acceptance]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with the same pair of sender_id and recipient_id' do
        existing_matching = create(:matching)
        matching.sender_id = existing_matching.sender_id
        matching.recipient_id = existing_matching.recipient_id
        expect(matching.valid?).to be_falsey
        expect(matching.errors[:sender_id]).to include('has already been taken')
      end
    end

    context 'Getter Methods' do
      it 'sender_name method should return the display_name of the associated sender.' do
        expect(matching.sender_name).to eq matching.sender.display_name
      end

      it 'recipient_name method should return the display_name of the associated recipient.' do
        expect(matching.recipient_name).to eq matching.recipient.display_name
      end
    end

    context 'Setter Methods.' do
      it 'update_acceptance_status! method should update the data of acceptance.' do
        existing_matching = create(:matching)
        previous_acceptance = existing_matching.acceptance
        desired_acceptance = (Matching.acceptances.values - [existing_matching.acceptance_before_type_cast]).sample
        existing_matching.update_acceptance!(acceptance: desired_acceptance)
        expect(existing_matching.acceptance).not_to eq previous_acceptance
      end
    end
  end
end
