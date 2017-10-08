# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Part < ApplicationRecord

  has_many :user_parts
  has_many :users, through: :user_parts

end
