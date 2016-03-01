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
  # mocks the $?.success? to true/false
  #
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end

  config.before(:all) { ENV["EXFILES_DEBUG"] = "true" }
  config.after(:all) { ENV["EXFILES_DEBUG"] = nil }
end
