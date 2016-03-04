require "exfiles/base"
require "exfiles/homebrew"

module Exfiles
  autoload :Base,     "exfiles/base"
  autoload :Homebrew, "exfiles/homebrew"

  extend Exfiles::Base
end
