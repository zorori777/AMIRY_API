# == Schema Information
#
# Table name: live_images
#
#  id         :integer          not null, primary key
#  live_id    :integer          not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LiveImage < ApplicationRecord
  # Mix-in
  include FileModelInterface

  # Association
  belongs_to :live

  # Uploader
  mount_uploader :name, LiveImageUploader
end
