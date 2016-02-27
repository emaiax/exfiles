module Exfile
  autoload :Homebrew, "exfile/homebrew"

  class << self
    def osx?
      RUBY_PLATFORM.downcase.include?("darwin")
    end

    def run(cmd)
      puts "[Running] #{cmd}"
      `#{cmd}` unless ENV["EXFILES_DEBUG"]
    end

    def welcome_msg
      puts
      puts "======================================================"
      puts "Welcome to EXFILES Installation."
      puts "======================================================"
      puts
    end

    def success_msg(action)
      puts ""
      puts "=========================================================="
      puts ""
      puts "EXFILES has been #{action}. Please restart your terminal and vim."
    end
  end
end
