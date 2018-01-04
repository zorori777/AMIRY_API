# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  user_id           :integer          unsigned, not null
#  target_model_type :integer          default(NULL), unsigned, not null
#  target_model_id   :integer          default(0), unsigned, not null
#  body              :string(255)      default(""), not null
#  status            :integer          default(NULL), unsigned, not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

describe Notification do
  let(:notification) { build(:notification) }

  describe 'Validations' do
    context 'with all necessary attributes.' do
      it 'is valid' do
        expect(notification).to be_valid
      end
    end

    context 'Presence Validation.' do
      context 'without all necessary attributes.' do
        it 'is invalid with nil body.' do
          notification.body = nil
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:body]).to include('can\'t be blank')
        end

        it 'is invalid with empty body.' do
          notification.body = ''
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:body]).to include('can\'t be blank')
        end

        it 'is invalid with nil user_id.' do
          notification.user_id = nil
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:user_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil target_model_type.' do
          notification.target_model_type = nil
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:target_model_type]).to include('can\'t be blank')
        end

        it 'is invalid with nil target_model_id.' do
          notification.target_model_id = nil
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:target_model_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil status.' do
          notification.status = nil
          expect(notification.valid?).to be_falsey
          expect(notification.errors[:status]).to include('can\'t be blank')
        end
      end
    end

    context 'Setter Methods' do
      it 'set_unread_status method inserts unread status to status column before a notification object gets saved.' do
        notification.status = nil
        notification.run_callbacks :save
        expect(notification.status).to eq 'unread'
      end
    end
  end
end
