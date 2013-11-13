class SessionsController < ApplicationController
  def new
  end

  api :POST, '/sessions', 'Sign in an user.'
  param :session, Hash, required: true, desc: 'The session object' do
    param :email, String, required: true
    param :password, String, required: true
  end
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  api :DELETE, '/signout', 'Sign out current user.'
  def destroy
    sign_out
    redirect_to root_path
  end
end
