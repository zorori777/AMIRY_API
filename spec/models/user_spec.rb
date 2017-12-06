# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  university_id             :integer          unsigned, not null
#  facebook_id               :integer          default(0), not null
#  facebook_token            :string(255)      default(""), not null
#  facebook_token_expires_at :integer          default(0), unsigned, not null
#  first_name                :string(255)      default(""), not null
#  last_name                 :string(255)      default(""), not null
#  display_name              :string(255)      default(""), not null
#  email                     :string(255)      default(""), not null
#  avatar                    :string(255)      default(""), not null
#  catch_copy                :string(255)      default(""), not null
#  self_introduction         :text(65535)      not null
#  bands_count               :integer          default(0), unsigned, not null
#  received_likes_count      :integer          default(0), unsigned, not null
#  sendable_likes_count      :integer          default(0), unsigned, not null
#  matchings_count           :integer          default(0), unsigned, not null
#  account_status            :integer          default(NULL), unsigned, not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  describe 'Validations' do
    context 'with all necessary attributes' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end
  end
end
