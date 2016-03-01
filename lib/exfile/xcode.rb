module Exfile
  module Xcode
    extend Base

    class << self
      def install
        if already_installed?
          puts "======================================================"
          puts "Xcode is already installed. The show must go on."
          puts "======================================================"
          puts
          puts
        else
          asks_to_install
        end
      end

      def already_installed?
        Dir.exist?("/Applications/Xcode.app")
      end

      def asks_to_install
        puts "======================================================"
        puts "Xcode must be installed to proceed."
        puts "======================================================"

        run %( xcode-select --install )
      end
    end
  end
end
