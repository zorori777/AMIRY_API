# == Schema Information
#
# Table name: bands
#
#  id          :integer          not null, primary key
#  circle_id   :integer          not null
#  name        :string(255)      default(""), not null
#  concept     :string(255)      default(""), not null
#  description :text(65535)      not null
#  people_num  :integer          default(0), unsigned, not null
#  type        :integer          default(NULL), unsigned, not null
#  united_at   :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Band do
  let(:band) { build(:band) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(band).to be_valid
      end
    end

    context 'without all necessary attributes' do
      context 'Presence Validation' do
        it 'is invalid with nil name.' do
          band.name = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with empty name.' do
          band.name = ''
          expect(band.valid?).to be_falsey
          expect(band.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with nil concept.' do
          band.concept = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:concept]).to include('can\'t be blank')
        end

        it 'is invalid with empty concept.' do
          band.concept = ''
          expect(band.valid?).to be_falsey
          expect(band.errors[:concept]).to include('can\'t be blank')
        end

        it 'is invalid with nil description.' do
          band.description = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with empty description.' do
          band.description = ''
          expect(band.valid?).to be_falsey
          expect(band.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with nil circle_id.' do
          band.circle_id = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:circle_id]).to include('can\'t be blank')
        end

        it 'is invalid with nil people_num.' do
          band.people_num = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:people_num]).to include('can\'t be blank')
        end

        it 'is invalid with nil type.' do
          band.type = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:type]).to include('can\'t be blank')
        end

        it 'is invalid with united_at.' do
          band.united_at = nil
          expect(band.valid?).to be_falsey
          expect(band.errors[:united_at]).to include('can\'t be blank')
        end
      end

      context 'Uniqueness Validation.' do
        it 'is invalid with the name that has already been taken in the same circle.' do
          existing_band = create(:band)
          band.circle_id, band.name = existing_band.circle_id, existing_band.name
          expect(band.valid?).to be_falsey
          expect(band.errors[:name]).to include('has already been taken')
        end
      end

      context 'Custom Validation.' do
        it 'is invalid with less than 4 people_num' do
          band.people_num = 3
          expect(band.valid?).to be_falsey
          expect(band.errors[:people_num]).to include('The number of a band should be between 4 and 7.')
        end

        it 'is invalid with more than 7 people_num.' do
          band.people_num = 10
          expect(band.valid?).to be_falsey
          expect(band.errors[:people_num]).to include('The number of a band should be between 4 and 7.')
        end
      end
    end
  end

  describe 'Instance Methods' do
    context 'Getter Methods' do
      it 'circle_name method should return the same name of the associated circle.' do
        expect(band.circle.name).to eq band.circle_name
      end
    end

    context 'Setter Methods.' do
      it 'set_emtpy_string_in_blank_description method should set empty string if description is empty.' do
        band.description = ''
        band.run_callbacks :save
        expect(band.description).to eq ''
      end
    end

    context 'Checker Methods.' do
      it 'intercollege? method should return false if intercollege is not zero.' do
        band.circle_id = 10
        expect(band.intercollege?).to be_falsey
      end
    end
  end
end
