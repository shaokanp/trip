class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end


  def show
    @user = User.find(params[:id])
    @trips = @user.trips.all
  end

  def new
    @user = User.new
  end

  api :POST, '/users', 'Create a new user.'
  param :user, Hash, required: true, desc: 'Register fields' do
    param :name, String, required: true, desc: 'The user name of this user.'
    param :email, String, required: true, desc: 'The email been typed in.'
    param :password, String, required: true, desc: 'The password been chosen.'
    param :password_confirmation, String, required: true, desc: 'The password confirmation.'
  end
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
