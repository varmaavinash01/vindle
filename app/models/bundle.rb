class Bundle
  class << self
    def all
      bundles = _read_all("*")
      
      bundles.each do |bundle|
        #Rails.logger.info "bundles = " + bundle["created_by"]
        bundle["created_by"] = User.get(bundle["created_by"])
      end
      bundles
    end
    
    def find(id)
      _read(id)
    end
    
    def save(bundle)
      Rails.logger.info "Bundle to save" + bundle.to_json
      _write(bundle["bid"], bundle)
    end
    
    def create(params)
      bundle = {}
      bundle["bid"] = _get_next_bid()
      bundle["bundle_name"] = params["bname"]
      bundle["created_by"] = params["user_id"]
      bundle["create_time"] = Time.now.utc
      bundle["display_picture"] = ""
      ## Default karma is 0
      bundle["karma"] = "0"
      ## Bundle initially has no videos
      bundle["videos"] = []
      bundle
    end

    def pushVid(bid, vid)
      bundle = _read(bid)
      if bundle
        bundle["videos"].push vid
      end
      save(bundle)
    end
    
    ## TODO make this instance method
    def removeVid(bid, vid)
      bundle = _read(bid)
      bundle["videos"].delete(vid)
      save(bundle)
    end
    
    def delete(id)
    end

    private
    def _get_next_bid
      ## TODO fix this logic. If count is zero all keys will be overwritten
      REDIS.incr(Settings.app_key + ":bundlecount").to_s
    end
    
    def _create_key(id)
      Settings.app_key + ":bundle:" + id
    end

    def _read(key)
      key = _create_key(key) unless key.start_with?(Settings.app_key + ":bundle:")
      bundle = REDIS.get(key)
      if bundle
        return ActiveSupport::JSON.decode(bundle)
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
    
    def _write(key, bundle)
      key = _create_key(key) unless key.start_with?(Settings.app_key + ":bundle:")
      if REDIS.set(key, bundle.to_json)
        Rails.logger.info "[OK] Write bundle to redis"
      else
        Rails.logger.info "[FAIL] Write bundle to redis"
      end
    end
  end
end