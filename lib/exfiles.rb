# frozen_string_literal: true

require "exfiles/base"
require "exfiles/homebrew"
require "exfiles/git"
require "exfiles/tty"

module Exfiles
  autoload :Tty,      "exfiles/tty"
  autoload :Base,     "exfiles/base"
  autoload :Git,      "exfiles/git"
  autoload :Homebrew, "exfiles/homebrew"

  extend Exfiles::Base
end
