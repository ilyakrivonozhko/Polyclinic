class Appointment < ApplicationRecord
  belongs_to :window
  belongs_to :user
  validates :window_id, uniqueness: true
end
