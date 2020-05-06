# frozen_string_literal: true

require "exfiles/version"

module Exfiles
  module Base
    extend self

    def ask_to_install(section)
      return true if ENV.fetch("ASK", "false") == "false"

      puts "Would you like to install configuration files for: #{section}? [Y]es, [n]o"

      STDIN.gets.chomp != "n"
    end

    def run(cmd)
      puts "[Running] #{cmd}"

      !`#{cmd}`.empty? unless ENV["DEBUG"]
    end

    def osx?
      RUBY_PLATFORM.downcase.include?("darwin")
    end

    def linux?
      RUBY_PLATFORM.downcase.include?("linux")
    end

    def welcome
      puts
      puts "======================================================"
      puts "Welcome to EXFILES Installation. #{Tty.emoji}"
      puts "======================================================"
      puts
    end

    def success
      puts
      puts "======================================================"
      puts
      puts "EXFILES has been successfully installed to ~/.dotfiles"
      puts "Please restart your terminal and vim."
      puts "Cheers #{Tty.emoji}"
    end

    def fail(reason)
      puts "======================================================"
      puts
      puts "We're very sorry, EXFILES couldn't be installed at this time. #{Tty.broken_heart}"
      puts "Please open an issue on Github following the link below:"
      puts
      puts CGI.escape("https://github.com/emaiax/dotfiles/issues/new?labels=bug&title=[#{VERSION}] #{reason}")
    end
  end
end
