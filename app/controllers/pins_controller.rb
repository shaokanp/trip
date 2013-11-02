class PinsController < ApplicationController
  before_action :init_trip
  before_action :signed_in_user

  def create
    @pin = @trip.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      #redirect_to root_url
    else
      #render 'static_pages/home'
    end
  end

  def show
    @pin = @trip.pins.find(params[:id])
    render json: @pin
  end

  def destroy
    @trip.pins.find(params[:id]).destroy
    flash[:success] = 'Trip destroyed.'
    redirect_to @trip
  end

  def update
    @pin = @trip.pins.find(params[:id])
    if @pin.update_attributes(pin_params)
      flash[:success] = 'Pin Updated.'
    else
      flash[:error] = 'Failed.'
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :start_time)
  end

  def init_trip
    @user = current_user
    @trip = @user.trips.find_by(params[:trip_id])
    if @trip.nil?
      flash[:error] = "Sorry, you don't have the permission to do that."
      redirect_to root_url
    end
  end

end
