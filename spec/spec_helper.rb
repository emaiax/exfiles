if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

unless ENV["NO_COVERAGE"]
  require "simplecov"
  SimpleCov.start { minimum_coverage "100" }
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "exfile"

RSpec.configure do |config|
  config.before(:all) { ENV["EXFILES_DEBUG"] = "true" }
  config.after(:all) { ENV["EXFILES_DEBUG"] = nil }
end
