class PinsController < ApplicationController
  before_action :init_trip
  before_action :signed_in_user
  before_action :correct_user, only:[:update, :destroy]

  def create
    @pin = @trip.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      render json: @pin
    end
  end

  def show
    @pin = @trip.pins.find(params[:id])
    render json: @pin
  end

  def destroy
    @trip.pins.find(params[:id]).destroy
    flash[:success] = 'Pin destroyed.'
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
    params.require(:pin).permit(:title, :start_time, :trip_id, :address)
  end

  def init_trip
    @trip = Trip.find(params[:trip_id])
  end

  def correct_user
    unless @trip.user_id == current_user.id?
      flash[:error] = 'Sorry, you do not have the permission to do that.'
      redirect_to root_path
    end
  end

end
