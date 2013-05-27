class User
  class << self
    def exist?(uid)
      if _read(_create_key(uid))
        return true
      else
        return false
      end 
    end
    
    def save(user)
      unless exist?(user["uid"])
        _write(_create_key(user["uid"]), user.to_json)
      end
    end
    
    def build(params)
      user = {}
      user["uid"]   = params["uid"].to_s
      user["name"]  = params["info"]["name"]
      user["image"] = params["info"]["image"]
      user["email"] = params["info"]["email"]
      user
    end
    
    def get(uid)
      _read(_create_key(uid))
    end
    
    private
    def _create_key(id)
      Settings.app_key + ":user:" + id
    end
    
    def _read(key)
      user = REDIS.get(key)
      if user
        return ActiveSupport::JSON.decode(user)
      end
      return nil
    end
    
    def _write(key, user)
      if REDIS.set(key, user)
        Rails.logger.info "[OK] Write user to redis"
      else
        Rails.logger.info "[FAIL] Write user to redis"
      end
    end
  end
end
