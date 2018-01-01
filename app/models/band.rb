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

class Band < ApplicationRecord
  # Needs this line because the table has a column named "type"
  self.inheritance_column = :_type_disabled

  # Callback
  before_save :set_emtpy_string_in_blank_description, if: :new_record?

  # Constants
  MIX_NUM = 4
  MAX_NUM = 7

  # Pagination
  paginates_per 15

  # Enum
  enum type: { only_men: 1, only_women: 2, mix: 3, sub_only_men: 4, sub_only_women: 5 }

  # Association
  belongs_to :circle,     optional: true
  has_many   :band_images
  has_many   :band_lives
  has_many   :lives,      through: :band_lives

  # Validation
  validates :name,                             uniqueness: { scope: :circle_id }
  validates :name, :concept,
            :circle_id, :people_num,
            :description, :type, :united_at,   presence: true
  validates :circle_id, :people_num, :type,    numericality: { only_integer: true }
  validate  :people_num_between_four_and_seven

  # Getter Methods
  def circle_name
    self.circle&.name.to_s
  end

  def intercollege_circle
    self.intercollege?
  end

  # Setter Methods
  def set_emtpy_string_in_blank_description
    self.description = '' if self.description.blank?
  end

  # Checker Methods
  def intercollege?
    self.circle_id.zero?
  end

  private

  # Custom Validation
  def people_num_between_four_and_seven
    return unless self.people_num.present?
    return if self.people_num >= MIX_NUM || self.people_num <= MAX_NUM
    errors.add(:people_num, 'The number of a band should be between 4 and 7.')
  end
end
