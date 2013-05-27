Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, Settings.yammer["app_key"], Settings.yammer["app_secrete"]
end