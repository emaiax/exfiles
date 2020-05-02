# frozen_string_literal: true

require "exfiles/version"

module Exfiles
  module Base
    extend self

    def name
      "EXFILES"
    end

    def path
      "~/.dotfiles"
    end

    def run(cmd)
      puts "[Running] #{cmd}"

      !`#{cmd}`.empty? unless ENV["EXFILES_DEBUG"]
    end

    def osx?
      RUBY_PLATFORM.downcase.include?("darwin")
    end

    def welcome
      puts
      puts "======================================================"
      puts "Welcome to #{name} Installation. #{Tty.emoji}"
      puts "======================================================"
      puts
    end

    def success
      puts
      puts "======================================================"
      puts
      puts "#{name} has been installed successfully. Please restart your terminal and vim. #{Tty.emoji}"
    end

    def fail(reason)
      puts "======================================================"
      puts
      puts "We're very sorry, #{name} couldn't be installed at this time. #{Tty.broken_heart}"
      puts "Please open an issue on Github following the link below:"
      puts
      puts CGI.escape("https://github.com/emaiax/dotfiles/issues/new?labels=bug&title=[#{VERSION}] #{reason}")
    end
  end
end
