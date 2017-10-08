# == Schema Information
#
# Table name: circle_images
#
#  id         :integer          not null, primary key
#  circle_id  :integer          not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CircleImage < ApplicationRecord

  # Enum
  enum name: { logo: 1, others: 2 }

  # Association
  belongs_to :circle

  # Uploader
  mount_uploaders :name, CircleImageUploader

end
