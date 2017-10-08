# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  university_id          :integer          not null
#  first_name             :string(255)      default(""), not null
#  last_name              :string(255)      default(""), not null
#  avatar                 :string(255)      default(""), not null
#  catchcopy              :string(255)      default(""), not null
#  self_introduction      :text(65535)      not null
#  bands_count            :integer          default(0), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Association
  has_many   :user_parts
  has_many   :user_circles
  has_many   :user_bands
  has_many   :user_lives
  has_many   :parts,       through: :user_parts
  has_many   :circles,     through: :user_circles
  has_many   :bands,       through: :user_bands
  has_many   :lives,       through: :user_lives
  has_many   :lectures
  belongs_to :university

  # Validation
  validates :first_name, :last_name, :catchcopy, 
            :self_introduction, :email,          presence: true
  validates :university_id, :bands_count,        numericality: true

  # Uploader
  mount_uploader :avatar, AvatarUploader

end
