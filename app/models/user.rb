# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  university_id          :integer          not null
#  first_name             :string(255)      default(""), not null
#  last_name              :string(255)      default(""), not null
#  display_name           :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  avatar                 :string(255)      default(""), not null
#  catchcopy              :string(255)      default(""), not null
#  self_introduction      :text(65535)      not null
#  bands_count            :integer          default(0), not null
#  received_likes_count   :integer          default(0), not null
#  sendable_likes_count   :integer          default(0), not null
#  matchings_count        :integer          default(0), not null
#  account_status         :integer          default(NULL), not null
#  provider               :string(255)      default(""), not null
#  uid                    :string(255)      default(""), not null
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
  before_save :set_display_name, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Constant
  REGISTERED   = 1
  UNREGISTERED = 2

  # Enum
  enum account_status: { registered: 1, unregistered: 2 }

  # Association
  belongs_to :university
  has_many   :user_parts
  has_many   :user_circles
  has_many   :user_bands
  has_many   :user_lives
  has_many   :parts,                  through: :user_parts
  has_many   :circles,                through: :user_circles
  has_many   :bands,                  through: :user_bands
  has_many   :lives,                  through: :user_lives
  has_many   :lectures
  has_many   :matchings
  has_many   :send_likes,             class_name: 'Like',         foreign_key: 'sender_id'
  has_many   :received_likes,         class_name: 'Like',         foreign_key: 'recipient_id'
  has_many   :send_introductions,     class_name: 'Introduction', foreign_key: 'sender_id'
  has_many   :received_introductions, class_name: 'Introduction', foreign_key: 'recipient_id' 

  # Validation
  validates :university_id, :first_name,
            :last_name, :email, :bands_count,
            :self_introduction, :catchcopy,   presence: true
  validates :university_id, :bands_count,
            :received_likes_count,
            :sendable_likes_count,
            :matchings_count,                 numericality: true
  validates :email,                           uniqueness: true

  # Uploader
  mount_uploader :avatar, AvatarUploader

  # Setter Methods
  def set_display_name
    self.display_name = "#{self.last_name} #{self.first_name}"
  end

end
