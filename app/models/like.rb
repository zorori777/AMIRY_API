# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Like < ApplicationRecord

  # Assocation
  belongs_to :sender,    foreign_key: 'sender_id',    class_name: 'User'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'User'

  # Validation
  validates :sender_id, :recipient_id, numericality: true, presence: true

  # Counter Culture
  counter_culture :recipient, column_name: 'likes_count'


end
