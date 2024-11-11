class SessionsController < ApplicationController
  def create

    if user = User.authnticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in succesfully!'
    else
      flash[:alert] = 'Invalid email or password.'
      render :new
    end
  end
end