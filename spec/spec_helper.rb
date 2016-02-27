$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "exfile"

RSpec.configure do |config|
  config.before(:all) { ENV["EXFILES_DEBUG"] = "true" }
  config.after(:all) { ENV["EXFILES_DEBUG"] = nil }
end
