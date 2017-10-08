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
#  type               :integer          default(0), unsigned, not null
#  hold_at            :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Live < ApplicationRecord

  # Needs this line because the table has a column named "type"
  self.inheritance_column = :_type_disabled

  # Association
  belongs_to :circle
  has_many   :band_lives
  has_many   :bands, through: :band_lives

  # Validation
  validates :name, :hold_at,           presence: true
  validates :circle_id, :max_capacity, 
            :reservations_count,       numericality: true
            
end
