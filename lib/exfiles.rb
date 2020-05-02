# frozen_string_literal: true

require "exfiles/base"
require "exfiles/homebrew"
require "exfiles/tty"

module Exfiles
  autoload :Tty,      "exfiles/tty"
  autoload :Base,     "exfiles/base"
  autoload :Homebrew, "exfiles/homebrew"

  extend Exfiles::Base
end
