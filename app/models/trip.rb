class Trip < ApplicationRecord
  belongs_to :user
  has_many :hometowns

  validates :name, presence: true
end
