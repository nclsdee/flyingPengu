class Trip < ApplicationRecord
  belongs_to :user
  has_many :hometowns, dependent: :destroy
  # accepts_nested_attributes_for :hometowns
  validates :name, presence: true
end
