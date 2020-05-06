# frozen_string_literal: true

module Exfiles
  module Homebrew
    extend Base
    extend self

    URL = "https://raw.githubusercontent.com/Homebrew/install/master/install"

    def install
      if already_installed?
        update_homebrew
      else
        install_homebrew
      end

      bundle_brewfile
    end

    private

    def already_installed?
      run "which brew"
    end

    def install_homebrew
      puts
      puts
      puts "======================================================"
      puts "Installing Homebrew, the OSX package manager...       "
      puts "If it's already installed, this will do nothing."
      puts "======================================================"

      run "curl -fsSL #{URL}"
    end

    def update_homebrew
      puts
      puts
      puts "======================================================"
      puts "Updating Homebrew."
      puts "======================================================"

      run "brew update"
    end

    def bundle_brewfile
      puts
      puts
      puts "======================================================"
      puts "Homebrewing packages with Brewfile... There may be some warnings."
      puts "======================================================"

      run "brew install zsh ctags git the_silver_searcher macvim"
    end
  end
end
