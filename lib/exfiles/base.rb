require "uri"
require_relative "version"

module Exfiles
  module Base
    extend self

    def run(cmd)
      puts "[Running] #{cmd}"
      `#{cmd}` unless ENV["EXFILES_DEBUG"]
    end

    def osx?
      RUBY_PLATFORM.downcase.include?("darwin")
    end

    def welcome_msg
      puts
      puts "======================================================"
      puts "Welcome to EXFILES Installation."
      puts "======================================================"
      puts
    end

    def success_msg(action)
      puts
      puts "======================================================"
      puts
      puts "EXFILES has been #{action}. Please restart your terminal and vim."
    end

    def fail_msg(reason)
      puts
      puts "======================================================"
      puts
      puts "We're very sorry, but EXFILES couldn't be installed at this time </3"
      puts "Please open an issue on Github following the link bellow:"
      puts
      puts URI.encode("https://github.com/emaiax/dotfiles/issues/new?labels=bug&title=[E#{Exfile::VERSION}] #{reason}")
    end
  end
end
