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

  def show
    @trip = @user.trips.find(params[:id])
    respond_to do |format|
       format.json { render :json => @trip }
    end
  end

  def destroy
    @user.trips.find(params[:id]).destroy
    flash[:success] = "Trip destroyed."
  end

  private

    def trip_params
      params.require(:trip).permit(:title)
    end

    def init_user
      @user = current_user
    end

end
