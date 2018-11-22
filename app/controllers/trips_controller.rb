require 'json'
require 'open-uri'
class TripsController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    @trips = Trip.where(user_id: current_user.id)

  end

  def show
    @footer = true
    @trip = Trip.find(params[:id])
    total_traveller = 0
    @trip.hometowns.each do |hometown|
      total_traveller += hometown['number_traveller']
    end
    @total_traveller = total_traveller
    # @results = @trip.best_city.first(5)
    @results = @trip.best_city_extended.first((params[:limit] || 5).to_i)
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
    # user = params[:email]
    # @path = trip_path(@trip)
    # UserMailer.share(current_user, @trip, @path).deliver
  end

  def send_email
    @trip = Trip.find(params["trip_id"].to_i)
    @path = trip_path(@trip)
    @email = params["email"]
    if UserMailer.share(@email, @trip, @path).deliver
    flash[:notice] = "You've successfully shared your itinerary!"
    redirect_to(@path)
    else
    redirect_to(@path)
  end
  end

  def new
    @trip = Trip.new
  end

  def create
    valid_cities = trip_params[:hometowns].select {|_, hometown|
        hometown[:city].present? &&\
      hometown[:number_traveller].present? &&\
      hometown[:date_from].present? &&\
      hometown[:date_to].present?
    }

    if valid_cities.keys.size < 2
      return redirect_to new_trip_path
    end

    @trip = Trip.new(name: trip_params[:name])
    @trip.user = current_user

    if @trip.save
      valid_cities.each do |hometown_params|
        # hometown_params[1] = {"city"=>"Paris", "number_traveller"=>"6"}
        hometown_params[1][:number_traveller].to_i

        hometown = Hometown.new(hometown_params[1])
        hometown.trip = @trip

        previous_one = Hometown.search(
          hometown_params[1][:city],
          hometown_params[1][:number_traveller],
          hometown_params[1][:date_from],
          hometown_params[1][:date_to],
          hometown_params[1][:direct],
        )

        if previous_one
          hometown.results = previous_one.results
        else
          if hometown_params[1][:direct].to_i == 1
          api_url = "https://api.skypicker.com/flights?flyFrom=#{hometown_params[1][:city]}&dateFrom=#{hometown_params[1][:date_from]}&dateTo=#{hometown_params[1][:date_from]}&returnFrom=#{hometown_params[1][:date_to]}&returnTo=#{hometown_params[1][:date_to]}&adults=#{hometown_params[1][:number_traveller].to_i}&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=0&limit=200&sort=price&asc=1"
          json = JSON.parse(open(api_url).read)
          hometown.results = json
        else
          api_url = "https://api.skypicker.com/flights?flyFrom=#{hometown_params[1][:city]}&dateFrom=#{hometown_params[1][:date_from]}&dateTo=#{hometown_params[1][:date_from]}&returnFrom=#{hometown_params[1][:date_to]}&returnTo=#{hometown_params[1][:date_to]}&adults=#{hometown_params[1][:number_traveller].to_i}&locale=en&partner=picky&v=3&xml=0&curr=EUR&price_from=1&max_stopovers=1&limit=200&sort=price&asc=1"
          json = JSON.parse(open(api_url).read)
          hometown.results = json
        end
        end

        hometown.save
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

