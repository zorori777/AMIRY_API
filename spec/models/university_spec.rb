# == Schema Information
#
# Table name: universities
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe University do
  let(:university) { build(:university) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(university).to be_valid
      end
    end

    context 'Presence Validation' do
      context 'without all necessary attributes' do
        it 'is invalid with name nil' do
          university.name = nil
          university.valid?
          expect(university.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with name blank' do
          university.name = ''
          university.valid?
          expect(university.errors[:name]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is valid with a different unique name' do
        a_university = build(:university, name: '早稲田大学')
        a_university.save
        b_university = build(:university, name: '上智大学')
        expect(b_university).to be_valid
      end

      it 'is invalid with the same name on university tables' do
        university_name = University.pluck(:name).sample
        university = build(:university, name: university_name)
        expect { university.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end

