class TripsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
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
        hometown = Hometown.new(trip_params[1])
        hometown.trip = @trip
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

    redirect_to root_url
  end

  private


  def trip_params
    params.require(:trip).permit!

  end

end

