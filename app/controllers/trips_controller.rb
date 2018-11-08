class TripsController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    @trips = Trip.where(user_id: current_user.id)
  end

  def show
    @trip = Trip.find(params[:id])
    @airports = Trip.airport_parse
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(name: trip_params[:name])
    @trip.user = current_user

    if @trip.save
      trip_params[:hometowns].each do |hometown_params|
        next unless hometown_params[:city].present?
        # hometown_params = {"city"=>"Paris", "number_traveller"=>"6"}
        hometown = Hometown.new(hometown_params)
        hometown.trip = @trip
        hometown.save
      end

      redirect_to trips_path

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

    redirect_to root_url
  end

  private


  def trip_params
    params.require(:trip).permit!
  end

end

