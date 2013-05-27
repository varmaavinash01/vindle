class AuthController < ApplicationController
  def index
    
  end
  
  def authenticate
  end

  def callback
    @user = User.build(request.env['omniauth.auth'])
    User.save(@user)
    session[:user] = @user
    redirect_to :controller => "bundles" , :action => "index"
    #redirect_to "/bundles"
  end

  def logout
    session.clear
    redirect_to :action => "index"
  end

  def stats
  end
end
