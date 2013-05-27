class AuthController < ApplicationController
  def index
    
  end
  
  def authenticate
  end

  def callback
    @user = request.env['omniauth.auth']
  end

  def logout
  end

  def stats
  end
end
