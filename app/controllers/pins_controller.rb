class PinsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only:[:update, :destroy]
  respond_to :json

  def create
    @trip = Trip.find(params[:pin][:trip_id])
    @pin = @trip.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      respond_to do |format|
        format.json { render json: @pin }
      end
    end
  end

  def show
    @pin = Pin.find(params[:id])
    render json: @pin
  end

  def destroy
    @pin.destroy
    flash[:success] = 'Pin destroyed.'
    respond_to do |format|
      format.json { head :no_content }
    end
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
    params.require(:pin).permit(:title, :start_time, :trip_id, :address, :pin_type, :longitude, :latitude)
  end


  def correct_user

    @pin = Pin.find(params[:id])
    @trip = @pin.trip
    unless @trip.user_id == current_user.id
      flash[:error] = 'Sorry, you do not have the permission to do that.'
      head :forbidden
    end
  end

end
