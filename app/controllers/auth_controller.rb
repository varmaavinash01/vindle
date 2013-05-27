class AuthController < ApplicationController
  def index
    
  end
  
  def authenticate
  end

  def callback
    @user = User.build(request.env['omniauth.auth'])
    User.save(@user)
    session[:user] = @user
    #redirect_to :controller => "" , :action => ""
  end

  def logout
    session.clear
  end

  def stats
  end
end
