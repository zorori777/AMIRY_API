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

class Live < ApplicationRecord
  # Needs this line because the table has a column named "type"
  self.inheritance_column = :_type_disabled

  # Pagination
  paginates_per 15

  # Scope
  scope :recent,  -> { order(hold_at: :desc) }

  # Association
  belongs_to :circle,    optional: true
  has_many   :band_lives
  has_many   :user_lives
  has_many   :bands,     through: :band_lives
  has_many   :users,     through: :user_lives

  # Validation
  validates :name, :hold_at,
            :max_capacity, :reservations_count, presence: true
  validates :circle_id, :max_capacity,
            :reservations_count,                numericality: true

  # Getter Methods
  def circle_name
    self.circle&.name.to_s
  end

  def available_seats_num
    self.max_capacity - self.reservations_count
  end

  # Checker Methods
  def seats_avaiable?
    self.available_seats.positive?
  end
end
