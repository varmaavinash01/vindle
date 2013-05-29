class BundlesController < ApplicationController
  before_filter :current_user
  before_filter :login_check
  def index
    @bundles = Bundle.all
  end

  def new
  end

  def create
    bundle = Bundle.create(params)
    Bundle.save(bundle)
    redirect_to :action => "index"
  end

  def show
    @bundle = Bundle.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
