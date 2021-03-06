# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

# Hometown.destroy_all
# Trip.destroy_all
# User.destroy_all

cities1 = ["MIL"]
cities2 = ["HAM"]
cities3 = ["VIE", "BCN", "MAD", "LIS"]

p "Creating entries"

link1 = "https://api.skypicker.com/flights?flyFrom=#{cities1[0]}&dateFrom=28/11/2018&dateTo=28/11/2018&returnFrom=01/12/2018&returnTo=01/12/2018&adults=1&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=1&limit=200&sort=price&asc=1&one_for_city=1"
link2 = "https://api.skypicker.com/flights?flyFrom=#{cities2[0]}&dateFrom=28/11/2018&dateTo=28/11/2018&returnFrom=01/12/2018&returnTo=01/12/2018&adults=1&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=1&limit=200&sort=price&asc=1"
link3 = "https://api.skypicker.com/flights?flyFrom=#{cities3[0]}&dateFrom=28/11/2018&dateTo=28/11/2018&returnFrom=01/12/2018&returnTo=01/12/2018&adults=1&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=1&limit=200&sort=price&asc=1"
link4 = "https://api.skypicker.com/flights?flyFrom=#{cities3[1]}&dateFrom=28/11/2018&dateTo=28/11/2018&returnFrom=01/12/2018&returnTo=01/12/2018&adults=1&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=1&limit=200&sort=price&asc=1"

puts link1
puts link2
puts link3
puts link4

# 2.times do |n|
#   user = User.create(
#     email: "flyingpengu#{n}@test.com",
#     password: "ABCDEFG",
#     password_confirmation: "ABCDEFG",
#   )

#   1.times do |nn|
#     trip = Trip.create(
#       name: "TestTrip #{nn}",
#       user: user,
#     )

#       hometown1 = Hometown.create(
#         trip: trip,
#         city: cities1.sample,
#         number_traveller: rand(1..3),
#         date_from: Date.new(2019,3,14),
#         date_to: Date.new(2019,3,18),
#         results: nil
#       )

#         hometown2 = Hometown.create(
#         trip: trip,
#         city: cities2.sample,
#         number_traveller: rand(1..3),
#         date_from: Date.new(2019,3,14),
#         date_to: Date.new(2019,3,18),
#         results: nil
#       )

#         hometown3 = Hometown.create(
#         trip: trip,
#         city: cities3.sample,
#         number_traveller: rand(1..3),
#         date_from: Date.new(2019,3,14),
#         date_to: Date.new(2019,3,18),
#         results: nil
#       )

#       url1 = "https://api.skypicker.com/flights?flyFrom=#{hometown1.city}&dateFrom=#{hometown1.date_from.strftime("%d%m%y")}&dateTo=#{hometown1.date_from.strftime("%d%m%y")}&returnFrom=#{hometown1.date_to.strftime("%d%m%y")}&returnTo=#{hometown1.date_to.strftime("%d%m%y")}&passengers=#{hometown1.number_traveller}&adults=1&locale=en&partner=picky&partner_market=us&v=3&xml=0&curr=EUR&price_from=1&maxstopovers=1&limit=100&sort=price&asc=1"
#       json = JSON.parse(open(url1).read)
#       hometown1.update(results: json)

#       url2 = "https://api.skypicker.com/flights?flyFrom=#{hometown2.city}&dateFrom=#{hometown2.date_from.strftime("%d%m%y")}&dateTo=#{hometown2.date_from.strftime("%d%m%y")}&returnFrom=#{hometown2.date_to.strftime("%d%m%y")}&returnTo=#{hometown2.date_to.strftime("%d%m%y")}&passengers=#{hometown2.number_traveller}&adults=1&locale=en&partner=picky&partner_market=us&v=3&xml=0&curr=EUR&price_from=1&maxstopovers=1&limit=100&sort=price&asc=1"
#       json = JSON.parse(open(url2).read)
#       hometown2.update(results: json)

#       url3 = "https://api.skypicker.com/flights?flyFrom=#{hometown3.city}&dateFrom=#{hometown3.date_from.strftime("%d%m%y")}&dateTo=#{hometown3.date_from.strftime("%d%m%y")}&returnFrom=#{hometown3.date_to.strftime("%d%m%y")}&returnTo=#{hometown3.date_to.strftime("%d%m%y")}&passengers=#{hometown3.number_traveller}&adults=1&locale=en&partner=picky&partner_market=us&v=3&xml=0&curr=EUR&price_from=1&maxstopovers=1&limit=100&sort=price&asc=1"
#       json = JSON.parse(open(url3).read)
#       hometown3.update(results: json)


#       # Hometown.create(
#       #   trip: trip,
#       #   city: cities.sample,
#       #   number_traveller: rand(1..3),
#       #   date_from: rand(1..3).week.ago,
#       #   date_to: rand(3..5).week.ago,
#       #   url = "https://api.skypicker.com/flights?flyFrom=#{hometown.city}&dateFrom=#{hometown.date_from}&dateTo=#{hometown.date_from}&returnFrom=#{hometown.date_to}&returnTo=#{hometown.date_to}&passengers=#{hometown.number_traveler}&adults=1&locale=en&partner=picky&partner_market=us&v=3&xml=0&curr=EUR&price_from=1&maxstopovers=1&limit=100&sort=price&asc=1"
#       #   results: json_api,
#       # )
#   end
# end

