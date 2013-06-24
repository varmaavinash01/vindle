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
    @videos = []
    @bundle["videos"].each do | vid |
      video = Video.find(vid)
      if video
        @videos.push video
      else
        Bundle.removeVid(@bundle["bid"], vid)
        ##  need to delete zombie video from bundle
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
