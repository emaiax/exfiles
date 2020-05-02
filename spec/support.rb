# frozen_string_literal: true

module Support
  extend self

  def stub_osx
    RSpec::Mocks::ConstantMutator.stub("Object::RUBY_PLATFORM", "x86_64-darwin14")
  end

  def stub_linux
    RSpec::Mocks::ConstantMutator.stub("Object::RUBY_PLATFORM", "x86_64-linux")
  end
end
