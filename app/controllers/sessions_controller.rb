class SessionsController < ApplicationController
  def new
  end

  api :POST, '/sessions', 'Sign in an user.'
  param :session, Hash, required: true, desc: 'The session object' do
    param :email, String, required: true
    param :password, String, required: true
    formats ['json', 'html']
  end
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user

      respond_to do |format|
        format.html { redirect_back_or root_path }
        format.json { render nothing:true, status: 200 }
      end
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      respond_to do |format|
        format.html { render 'new' }
        format.json { render status: 403 }
      end
      render 'new'
    end
  end

  api :DELETE, '/signout', 'Sign out current user.'
  def destroy
    sign_out
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render status: 200 }
    end
  end
end
