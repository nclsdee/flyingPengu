class HometownsController < ApplicationController

  def new
    @hometown = Hometown.new
    @trip = Trip.find(params[:trip_id])
  end

  def create
    @hometown = Hometown.new(hometown_params)
    @hometown.trip = Trip.find(params[:trip_id])


    @hometown.trip_id = @trip.id
    @hometown.save

    redirect_to trips_path
  end

  private

  def hometown_params
    params.require(:hometown).permit!
  end
end
