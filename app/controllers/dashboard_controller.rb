class DashboardController < ApplicationController

  def index
    @user = User.find(params[:id])
    @trips = @user.trips.all
  end

end
