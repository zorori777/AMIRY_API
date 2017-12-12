# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :integer          default(NULL), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Part do
  let(:part) { build(:part) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(part).to be_valid
      end
    end

    context 'Presence Validation' do
      context 'without all necessary attributes' do
        it 'is invalid with name nil' do
          part.name = nil
          expect(part.valid?).to be_falsey
          expect(part.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with name blank' do
          part.name = ''
          expect(part.valid?).to be_falsey
          expect(part.errors[:name]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is valid with a different unique name' do
        existing_part = create(:part)
        part.name = existing_part.name
        expect(part.valid?).to be_falsey
        expect(part.errors[:name]).to include('has already been taken')
      end
    end
  end
end
