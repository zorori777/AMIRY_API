# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  body         :string(255)      default(""), not null
#  image        :string(255)      default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Message do
  let(:message) { build(:message) }

  describe 'Validations' do
    context 'with all necessary attributes.' do
      it 'is valid' do
        expect(message).to be_valid
      end
    end

    context 'Presence Validation.' do
      context 'without all necessary attributes.' do
        it 'is invalid with nil sender_id.' do
          message.sender_id = nil
          expect(message.valid?).to be_falsey
          expect(message.errors[:sender_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil recipient_id.' do
          message.recipient_id = nil
          expect(message.valid?).to be_falsey
          expect(message.errors[:recipient_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil body and image.' do
          message.body = nil
          message.image = nil
          expect(message.valid?).to be_falsey
          expect(message.errors[:body_or_image]).to include('can\'t be blank')
        end

        it 'is invalid with empty body and image.' do
          message.body = ''
          message.image = ''
          expect(message.valid?).to be_falsey
          expect(message.errors[:body_or_image]).to include('can\'t be blank')
        end
      end
    end

    context 'Getter Methods' do
      it 'sender_name method returns the display name who sent the message.' do
        expect(message.sender_name).to eq message.sender.display_name
      end

      it 'recipient_name method returns the display name who received the message.' do
        expect(message.sender_name).to eq message.sender.display_name
      end
    end
  end
end
