module Exfile
  module Homebrew
    extend Base

    class << self
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
        run %( which brew )
        $CHILD_STATUS.success?
      end

      def install_homebrew
        puts
        puts
        puts "======================================================"
        puts "Installing Homebrew, the OSX package manager...If it's"
        puts "already installed, this will do nothing."
        puts "======================================================"
        run %( ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" )
      end

      def update_homebrew
        puts
        puts
        puts "======================================================"
        puts "Updating Homebrew."
        puts "======================================================"
        run %( brew update )
      end

      def bundle_brewfile
        puts
        puts
        puts "======================================================"
        puts "Installing Homebrew packages with Brewfile...There may be some warnings."
        puts "======================================================"
        # run %{brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher}
        # run %{brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit}
        run %( brew bundle Brewfile )
        puts
        puts
      end
    end
  end
end
