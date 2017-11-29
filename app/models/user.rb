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
  before_save :set_display_name, :set_empty_self_introduction,
              :set_no_university_status, :set_account_status_registered, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  # Constant
  NO_UNIVERSITY = 0
  REGISTERED    = 1
  UNREGISTERED  = 2

  # Enum
  enum account_status: { registered: 1, unregistered: 2 }

  # Association
  belongs_to :university,             optional: true
  has_many   :user_parts
  has_many   :user_circles
  has_many   :user_bands
  has_many   :user_lives
  has_many   :parts,                  through: :user_parts
  has_many   :circles,                through: :user_circles
  has_many   :bands,                  through: :user_bands
  has_many   :lives,                  through: :user_lives
  has_many   :introductions,                                      foreign_key: 'recipient_id'
  has_many   :lectures
  has_many   :matchings
  has_many   :send_likes,             class_name: 'Like',         foreign_key: 'sender_id'
  has_many   :received_likes,         class_name: 'Like',         foreign_key: 'recipient_id'
  has_many   :send_introductions,     class_name: 'Introduction', foreign_key: 'sender_id'
  has_many   :received_introductions, class_name: 'Introduction', foreign_key: 'recipient_id' 

  # Validation
  validates :first_name, :last_name, :email, presence: true
  validates :bands_count,
            :received_likes_count,
            :sendable_likes_count,
            :matchings_count,                numericality: true
  validates :email,                          uniqueness: true

  # Uploader
  mount_uploader :avatar, AvatarUploader

  # Class methods
  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create!(
        email:             auth.info.email,
        password:          Devise.friendly_token[0,20],
        first_name:        auth.info.first_name,
        last_name:         auth.info.last_name,
        remote_avatar_url: auth.info.image
      )
    end
  end

  # Getter methods
  def university_name
    self.university&.name.to_s
  end

  def avatar_link
    self.avatar.file.filename
  end

  # Setter Methods
  def set_display_name
    self.display_name = "#{self.last_name} #{self.first_name}"
  end

  def set_empty_self_introduction
    self.self_introduction = ""
  end

  def set_no_university_status
    self.university_id = NO_UNIVERSITY
  end

  def set_account_status_registered
    self.account_status = REGISTERED
  end

end
