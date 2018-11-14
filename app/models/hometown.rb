class Hometown < ApplicationRecord
  belongs_to :trip

  # validates :date_from, :date_to, :city, :number_traveller, presence: true

  def self.search(city, number_traveller, date_from, date_to)
    max_created_at = 1.hours.ago

   # city: "VIE",
   # number_traveller: 1,
   # date_from: Thu, 21 Feb 2019,
   # date_to: Sun, 24 Feb 2019,

    query = self.where(
      city: city,
      number_traveller: number_traveller.to_i,
      date_from: date_from.to_date,
      date_to: date_to.to_date
    )

    query = query.where("created_at >= ?", max_created_at)
    query.first
  end
end
