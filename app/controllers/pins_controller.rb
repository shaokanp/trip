class PinsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only:[:update, :destroy]
  respond_to :json

  api :POST, '/pins', 'Create a new pin.'
  param :pin, Hash, required: true, desc: 'The pin to create.' do
    param :title, String, required: true, desc: 'The title of this pin.'
    param :address, String, required: true, desc: 'The address of this pin.'
    param :start_time, String, desc: 'The start time of this pin.'
  end
  def create
    @trip = Trip.find(params[:pin][:trip_id])
    @pin = @trip.pins.build(pin_params)
    if @pin.save
      flash[:success] = 'Pin created !'
      respond_to do |format|
        format.json { render json: @pin }
      end
    else
      respond_to do |format|
        format.json { render @pin.errors }
      end
    end
  end

  api :GET, '/pins/:id', 'Get a specified pin.'
  param :id, String, required: true, desc: 'The numeric id of the desired pin.'
  def show
    @pin = Pin.find(params[:id])
    render json: @pin
  end

  api :Delete, '/pins/:id', 'Delete a pin.'
  param :id, String, required: true
  def destroy
    @pin.destroy
    flash[:success] = 'Pin destroyed.'
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # resort the pins
  api :POST, '/pins/sort', "Update the pin's order."
  example "'pin' : [1,4,3,2,5]"
  param :pin, Array, required: true, desc: 'The new id order in an array format.'
  def sort
    params[:pin].each_with_index do |id, index|
      Pin.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  api :PATCH, '/pin/:id', 'Update a pin.'
  param :id, String, required: true, desc: 'The numeric id of the pin to update.'
  param :pin, Hash, required: true, desc: 'The pin object that want to be update.' do
    param :title, String, desc: 'The title of this pin.'
    param :address, String, desc: 'The address of this pin.'
    param :start_time, String, desc: 'The start time of this pin.'
  end
  def update
    if @pin.update_attributes(pin_params)
      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 200 }
      end
    else
      respond_to do |format|
        format.html
        format.json { render nothing: true, status: 400 }
      end
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :start_time, :end_time, :trip_id, :address, :pin_type, :longitude, :latitude, :position)
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
