class TripsController < ApplicationController
  before_action :signed_in_user

  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      flash[:success] = "Trip created !"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def trip_params
      params.require(:trips).permit(:title)
    end

end
