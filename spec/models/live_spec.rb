# == Schema Information
#
# Table name: lives
#
#  id                 :integer          not null, primary key
#  circle_id          :integer          not null
#  name               :string(255)      default(""), not null
#  description        :text(65535)      not null
#  max_capacity       :integer          default(0), unsigned, not null
#  reservations_count :integer          default(0), unsigned, not null
#  hold_at            :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

describe Live do
  let(:live) { build(:live) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(live).to be_valid
      end
    end

    context 'Presence Validation' do
      context 'without all necessary attributes' do
        it 'is invalid with nil name.' do
          live.name = nil
          expect(live.valid?).to be_falsey
          expect(live.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with blank name' do
          live.name = ''
          expect(live.valid?).to be_falsey
          expect(live.errors[:name]).to include('can\'t be blank')
        end

        it 'is invalid with nil description' do
          live.description = nil
          expect(live.valid?).to be_falsey
          expect(live.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with blank description.' do
          live.description = ''
          expect(live.valid?).to be_falsey
          expect(live.errors[:description]).to include('can\'t be blank')
        end

        it 'is invalid with nil max_capacity.' do
          live.max_capacity = nil
          expect(live.valid?).to be_falsey
          expect(live.errors[:max_capacity]).to include('can\'t be blank')
        end

        it 'is invalid with nil reservations_count.' do
          live.reservations_count = nil
          expect(live.valid?).to be_falsey
          expect(live.errors[:reservations_count]).to include('can\'t be blank')
        end
      end
    end

    context 'Uniqueness Validation' do
      it 'is invalid with name that has been already taken.' do
        existing_live = create(:live)
        live.name = existing_live.name
        expect(live.valid?).to be_falsey
        expect(live.errors[:name]).to include('has already been taken')
      end
    end

    context 'Custom Validation' do
      it 'is valid with earlier datetime than now.' do
        live.hold_at = Date.today.prev_day
        expect(live.valid?).to be_falsey
        expect(live.errors[:hold_at]).to include('The live should be held at after now.')
      end
    end
  end

  describe 'Instance Methods' do
    context 'Getter Methods' do
      it 'circle_name method should return the same one as the name of the associated circle.' do
        expect(live.circle.name).to eq live.circle_name
      end

      it 'avaiable_seats_num method should return the same number as the difference between max_capacity and reservations_count' do
        expect(live.available_seats_num).to eq (live.max_capacity - live.reservations_count)
      end
    end

    context 'Setter Methods' do
      it 'set_empty_string_in_description method inserts empty string to description column before a live object gets saved if the data for description is blank.' do
        live.description = nil
        live.run_callbacks :save
        expect(live.description).to eq ''
      end
    end

    context 'Checker Methods' do
      it 'seats_avaiable? method should return false if its the numher of max_capacity is lessc than that of reservations_count.' do
        live.max_capacity = 5
        live.reservations_count = 10
        expect(live.seats_available?).to be_falsey
      end
    end
  end
end
