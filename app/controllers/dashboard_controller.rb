class DashboardController < ApplicationController

  api :GET, '/trips', 'List all trips belong to the specified user.'
  param :id, String, desc: 'The numeric id of the specified user.', required: true
  def index
    @user = User.find(params[:id])
    @trips = Trip.where('user_id = ?', params[:id])
  end

end
