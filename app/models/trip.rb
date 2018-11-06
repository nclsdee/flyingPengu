class Trip < ApplicationRecord
  belongs_to :user
  has_many :hometowns, dependent: :destroy

  validates :name, presence: true
end
