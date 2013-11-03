class PinsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only:[:update, :destroy]

  def create
    @trip = Trip.find(params[:pin][:trip_id])
    @pin = @trip.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      render json: @pin
    end
  end

  def show
    @pin = Pin.find(params[:id])
    render json: @pin
  end

  def destroy
    @pin.destroy
    flash[:success] = 'Pin destroyed.'
    redirect_to @trip
  end

  def update
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


  def correct_user

    @pin = Pin.find(params[:id])
    @trip = @pin.trip

    unless @trip.user_id == current_user.id
      flash[:error] = 'Sorry, you do not have the permission to do that.'
    end
  end

end
