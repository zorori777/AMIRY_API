# == Schema Information
#
# Table name: circles
#
#  id            :integer          not null, primary key
#  university_id :integer          not null
#  name          :string(255)      default(""), not null
#  description   :string(255)      default(""), not null
#  members_count :integer          default(0), unsigned, not null
#  bands_count   :integer          default(0), unsigned, not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

describe Circle do
  let(:circle) { build(:circle) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(circle).to be_valid
      end
    end

    context 'Presence Validation' do
      context 'without all necessary attributes' do
        it 'is invalid with nil name.' do
          circle.name = nil
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with blank name' do
          circle.name = ''
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with nil description' do
          circle.description = nil
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with blank description.' do
          circle.description = ''
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with nil members_count.' do
          circle.members_count = nil
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:members_count]).to include('can\'t be blank')
        end

        it 'is invalid with nil bands_count.' do
          circle.bands_count = nil
          expect(circle.valid?).to be_falsey
          expect(circle.errors[:bands_count]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with a different unique name' do
        existing_circle = create(:circle)
        circle.university = existing_circle.university
        circle.name = existing_circle.name
        expect(circle.valid?).to be_falsey
        expect(circle.errors[:name]).to include('has already been taken')
      end
    end
  end

  describe 'Getter methods' do
    it 'university_name gets the name of the associated university' do
      circle = create(:circle)
      university = circle.university
      expect(circle.university_name).to eq university.name
    end
  end
end
