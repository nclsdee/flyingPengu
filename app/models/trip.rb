class Trip < ApplicationRecord
  belongs_to :user
  has_many :hometowns, dependent: :destroy
  # accepts_nested_attributes_for :hometowns
  validates :name, presence: true

  AIRPORTS = JSON.parse(File.read("#{Rails.root}/config/airports.json"))
  AIRLINES = JSON.parse(File.read("#{Rails.root}/config/airlines.json"))

  def airports_in_common
    destinations_by_hometowns = {}

    self.hometowns.each do |hometown|
      possible_destinations = hometown.results["data"].map {|flight| flight["flyTo"]}.uniq
      destinations_by_hometowns[hometown.id] = possible_destinations
    end

    all_possible_destinations = destinations_by_hometowns.values
    intersection_between_hometowns = all_possible_destinations.inject(:&)

    intersection_between_hometowns
  end

  def sorted_possible_connections
    airports = self.airports_in_common
    possible_connections = []
    sorted_result = []
    self.hometowns.each do |hometown|
      airports.each do |airport|
        hometown.results["data"].each do |flight|
          if flight['flyTo'] == airport
            possible_connections << flight
          end
        end
      end
    end

    possible_connections
    result = possible_connections.group_by do |value|
      value['flyTo']
    end

    sorted_results = result.map do |key, value|
      # key: "DUB"
      # value: array
        # value.sort_by { |value| value["price"]}.map {|value| value.slice('flyTo', 'flyFrom', 'price')}
        value.sort_by { |value| value["price"]}.map {|value| value}
      # value.sort_by { |value| value["price"]}.map {|value| value.slice('flyTo', 'flyFrom', 'price', 'quality', 'fly_duration', 'return_duration', 'airlines', 'deep_link')}
    end

    sorted_results
  end

  def best_pricing
    possible_connections = self.sorted_possible_connections.map do |flights|
      flights.map do |flight|
        hometown = Hometown.find_by(city: flight['flyFrom'])

        new_price = hometown.number_traveller * flight['price']
        flight['price_total'] = new_price
        flight['number_traveller'] = hometown.number_traveller

        flight
      end
    end

    possible_connections
  end

  def best_city
    best_pricing = self.best_pricing
    cities_scores = {}

    best_pricing.each do |flights|
      total_price = flights.inject(0){|sum, flight| sum + flight['price_total'] }
      total_travellers = flights.inject(0){|sum, flight| sum + flight['number_traveller'] }

      score = total_price.to_f / total_travellers.to_f
      city = flights.first["flyTo"]
      flights_for_this_city = flights.select { |flight| flight["flyTo"] == city }

      cities_scores[city] = [score, flights_for_this_city]
    end

    cities_scores.sort_by {|_key, value| value[0] }.to_h
  end

  def best_city_extended
    sorted_city_scores = self.best_city
    new_data = {}
    sorted_city_scores.each do |key, value|
      airport = Trip.airport_by_iata(key)

      value[1] = value[1].map do |flight|
        if airport[flight['city']].present?
        flight['city'] = airport['city']
        flight['country'] = airport['country']
        flight['latitude'] = airport['latitude'].to_f
        flight['longitude'] = airport['longitude'].to_f
        flight
      end
      end

      new_data[key] = [value[0], value[1]]
    end
    new_data
  end

  def self.airport_parse
    AIRPORTS
  end

  def self.airport_by_iata(iata)
    self.airport_parse[iata]
  end

  def self.airline_parse
    AIRLINES
  end

end
