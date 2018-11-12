require 'json'
require 'open-uri'
class TripsController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  def show
    @trip = Trip.find(params[:id])
    # @results = @trip.best_city.first(5)
    @results = @trip.best_city_extended.first(5)
    @airports = Trip.airport_parse
    @airlines = Trip.airline_parse
    @hometowns = @trip.hometowns.map {|towns| towns.slice('city')}
    @hometownMarkers = @hometowns.map do |hometown|

      {
        lat: Trip.airport_by_iata(hometown['city'])["latitude"].to_f,
        lng: Trip.airport_by_iata(hometown['city'])["longitude"].to_f,
        icon: view_context.image_path('hometown-pin medium.png')
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end

   @destinationMarkers = @results.map do |city|
      {
        lat: city[1][1][0]["latitude"],
        lng: city[1][1][0]["longitude"],
        icon: view_context.image_path('destination-pin medium.png')
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }

    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(name: trip_params[:name])
    @trip.user = current_user


    if @trip.save
      trip_params[:hometowns].each do |hometown_params|
        next unless hometown_params[1][:city].present?
        # hometown_params = {"city"=>"Paris", "number_traveller"=>"6"}
        hometown_params[1][:number_traveller].to_i
        hometown = Hometown.new(hometown_params[1])
        hometown.trip = @trip
        hometown.save
        api_url = "https://api.skypicker.com/flights?flyFrom=#{hometown_params[1][:city]}&dateFrom=#{hometown_params[1][:date_from]}&dateTo=#{hometown_params[1][:date_from]}&returnFrom=#{hometown_params[1][:date_to]}&returnTo=#{hometown_params[1][:date_to]}&passengers=#{hometown_params[1][:number_traveller].to_i}&adults=1&locale=en&partner=picky&partner_market=us&v=3&xml=0&curr=EUR&price_from=1&maxstopovers=1&limit=100&sort=price&asc=1"
        json = JSON.parse(open(api_url).read)
        hometown.update(results: json)

      end

      redirect_to trip_path(@trip)

    else
      render :new
    end

  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)

    redirect_to root_url
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    redirect_to trips_url
  end

  private


  def trip_params
    params.require(:trip).permit!

  end

end

