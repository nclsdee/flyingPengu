class Hometown < ApplicationRecord
  belongs_to :trip

  validates :date_from, :date_to, :city, :number_traveller, presence: true
end
