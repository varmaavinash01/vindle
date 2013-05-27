require 'yaml'
require 'ostruct'

begin
  Settings = YAML.load_file('config/settings.yml')
  Settings = OpenStruct.new(Settings)
rescue
  Settings = nil
end

if Settings
  p "[OK] Settings loaded." 
else
  p "[FAIL] Settings loading failed."
end