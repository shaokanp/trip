class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def contact
  end

  def index
    if signed_in?
      redirect_to dashboard_path(id: current_user.id)
    else
      redirect_to home_path
    end
  end
end
