class SessionsController < ApplicationController
  def new
  end
  
  def create
    # TODO: authenticate user
    @user = User.where({ email: params["email"] })[0]
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session["user_id"] = @user.id
        flash[:notice] = "You logged in!"
        redirect_to "/posts"
      else
          flash[:notice] = "Error logging in!"
          redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Error logging in!"
      redirect_to "/sessions/new"
    end
  end
end
