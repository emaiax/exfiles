# frozen_string_literal: true

require "exfiles"
require "support"
require "simplecov"
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start if ENV["CI"]

SimpleCov.start { minimum_coverage 100 } unless ENV["NO_COVERAGE"]

$LOAD_PATH.unshift File.expand_path("../../lib", __dir__)

RSpec.configure do |config|
  # mocks the $?.success? to true/false
  #
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end

  config.before(:all) { ENV["EXFILES_DEBUG"] = "true" }
  config.after(:all) { ENV["EXFILES_DEBUG"] = nil }

  config.include Support
end
