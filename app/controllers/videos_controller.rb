class VideosController < ApplicationController
  def index
  end

  def create
    video = Video.create(params)
    Rails.logger.info "********* Video created = " + video.to_json
    Video.save(video)
    Bundle.pushVid(params["bundle_id"], video["vid"])
    redirect_to :back
  end

  def new
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
