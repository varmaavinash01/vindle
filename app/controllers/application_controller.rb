class ApplicationController < ActionController::Base
  protect_from_forgery
  def current_user
    @user = session[:user]
  end
  
  def login_check
    unless @user
      redirect_to :controller => "auth", :action => "index"
    end
  end
end
