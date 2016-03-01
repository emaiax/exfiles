require_relative "exfile/base"
require_relative "exfile/homebrew"

module Exfile
  autoload :Base,     "exfile/base"
  autoload :Homebrew, "exfile/homebrew"

  extend Exfile::Base
end
