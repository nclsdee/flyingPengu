class TripsController < ApplicationController
  before_action :find_trip

  def index
    @trips = Trip.all
  end

  def show
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.save

    redirect_to root_url
  end

  def edit
  end

  def update
    @trip.update(trip_params)

    redirect_to root_url
  end

  def destroy
    @trip.destroy

    redirect_to root_url
  end

  private

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit!
  end

end

