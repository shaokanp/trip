class TripsController < ApplicationController
  before_action :signed_in_user
  before_action :init_user

  def new
    @trip = current_user.trips.build
  end

  def create
    @trip = @user.trips.build(trip_params)
    if @trip.save
      flash[:success] = "Trip created !"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def show
    @trip = @user.trips.find(params[:id])
  end

  def destroy
    @user.trips.find(params[:id]).destroy
    flash[:success] = "Trip destroyed."
    redirect_to dashboard_path
  end

  private

    def trip_params
      params.require(:trip).permit(:title)
    end

    def init_user
      @user = current_user
    end

end
