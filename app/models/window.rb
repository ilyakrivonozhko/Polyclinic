class Window < ApplicationRecord
  belongs_to :user
  validates :datetime, presence: true
end
