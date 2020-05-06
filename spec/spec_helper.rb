# frozen_string_literal: true

require "simplecov"
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start if ENV["CI"]

SimpleCov.start do
  minimum_coverage 100

  add_filter "spec"
end unless ENV["NO_COVERAGE"]

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "exfiles"
require "support"

RSpec.configure do |config|
  # mocks the $?.success? to true/false
  #
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end

  config.before(:all) { ENV["DEBUG"] = "true" }
  config.after(:all) { ENV["DEBUG"] = nil }

  config.include Support
end
