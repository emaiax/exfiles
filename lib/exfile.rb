require_relative "exfile/base"
require_relative "exfile/homebrew"
require_relative "exfile/xcode"

module Exfile
  autoload :Base,     "exfile/base"
  autoload :Homebrew, "exfile/homebrew"
  autoload :Xcode,    "exfile/xcode"

  extend Exfile::Base
end
