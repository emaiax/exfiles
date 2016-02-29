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
      end

      private

      def already_installed?
        run %{which brew}
        $?.success?
      end

      def install_homebrew
        puts "======================================================"
        puts "Installing Homebrew, the OSX package manager...If it's"
        puts "already installed, this will do nothing."
        puts "======================================================"
        run %{ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"}
      end

      def update_homebrew
        puts
        puts
        puts "======================================================"
        puts "Updating Homebrew."
        puts "======================================================"
        run %{brew update}
        puts
        puts
        puts "======================================================"
        puts "Installing Homebrew packages...There may be some warnings."
        puts "======================================================"
        run %{brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher}
        run %{brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit}
        puts
        puts
      end
    end
  end
end
