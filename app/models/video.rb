class Video
  class << self
    def all
      
    end
    
    def find(id)
      _read(id)
    end
    
    def save(video)
      Rails.logger.info "video to save" + video.to_json
      _write(video["vid"], video)
    end
    
    def create(params)
      video = {}
      video["vid"] = _get_next_vid()
      video["name"] = params["vname"]
      video["created_by"] = params["user_id"]
      video["create_time"] = Time.now.utc
      video["link"] = params["vlink"]
      ## TODO get youtube url and test for variations
      ## http://img.youtube.com/vi/<insert-youtube-video-id-here>/0.jpg
      video["display_picture"] = _get_video_pic_url video["link"]
      ## Default karma is 0
      video["karma"] = "0"
      ## Bundle initially has no videos
      video["bundle_ids"] = [params["bundle_id"]]
      video
    end

    def delete(id)
    end

    private
    
    def _get_video_pic_url(vlink)
      "http://img.youtube.com/vi/#{vlink.split('?')[1].split('&')[0].split('=')[1]}/0.jpg"
    end
    def _get_next_vid
      ## TODO fix this logic. If count is zero all keys will be overwritten
      REDIS.incr(Settings.app_key + ":videocount").to_s
    end
    
    def _create_key(id)
      Settings.app_key + ":video:" + id
    end

    def _read(key)
      key = _create_key(key) unless key.start_with?(Settings.app_key + ":video:")
      video = REDIS.get(key)
      if video
        return ActiveSupport::JSON.decode(video)
      end
      return nil
    end
        
    def _read_all(key)
      key = _create_key(key)
      keys = REDIS.keys(key)
      bundles = []
      keys.each do |key|
        bundles.push _read(key)
      end
      bundles
    end
    
    def _write(key, video)
      key = _create_key(key) unless key.start_with?(Settings.app_key + ":video:")
      if REDIS.set(key, video.to_json)
        Rails.logger.info "[OK] Write video to redis"
      else
        Rails.logger.info "[FAIL] Write video to redis"
      end
    end
  end
end