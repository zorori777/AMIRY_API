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
  has_many   :user_bands
  has_many   :lives,      through: :band_lives
  has_many   :users,      through: :user_bands

  # Validation
  validates :name,                             uniqueness: { scope: :circle_id }
  validates :name, :concept,
            :circle_id, :people_num,
            :description, :type, :united_at,   presence: true
  validates :circle_id, :people_num, :type,    numericality: { only_integer: true }

  # Getter Methods
  def circle_name
    self.circle&.name.to_s
  end

  def intercollege_circle
    self.intercollege?
  end

  def image_urls
    self.band_images.map(&:file_url)
  end

  # Setter Methods
  def set_emtpy_string_in_blank_description
    self.description = '' if self.description.blank?
  end

  # Checker Methods
  def intercollege?
    self.circle_id.zero?
  end

  def additional_people_num_within_range?(additional_people_num:)
    self.people_num + additional_people_num >= MIX_NUM && self.people_num + additional_people_num <= MAX_NUM
  end
end
