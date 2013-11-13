class TripsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only:[:destroy]

  api :POST, '/trips', 'Create a new trip.'
  param :trip, Hash, required: true, desc: 'The trip to create.' do
    param :title, String, required: true
  end
  def create
    @trip = current_user.trips.build(trip_params)
    if @trip.save
      flash[:success] = "Trip created !"
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json do
         render :json => @trip.to_json
        end
      end
    else
      respond_to do |format|
        format.html { render 'static_pages/home' }
        format.json { head :no_content }
      end
    end
  end

  api :GET, '/trips/:id', 'Get the trip with specified id.'
  param :id, String, desc: 'The numeric id of desired trip.'
  def show
    @trip = Trip.find(params[:id])
  end

  def destroy
    @trip.destroy
    flash[:success] = "Trip destroyed."
  end

  private

    def trip_params
      params.require(:trip).permit(:title)
    end

    def correct_user
      @trip = current_user.trips.find_by(id: params[:id])
      if @trip.nil?
        flash[:error] = "Sorry, you don't have the permission to do that."
        head :forbidden
      end
    end

end
