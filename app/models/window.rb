class Window < ApplicationRecord
  belongs_to :user
  has_one :appointment, dependent: :destroy
  validates :datetime, presence: true
end
