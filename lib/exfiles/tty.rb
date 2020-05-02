# frozen_string_literal: true

# :nocov:
module Exfiles
  module Tty
    extend self

    # necessary for 1.8.7 unicode handling since many installs are on 1.8.7
    def tick
      @tick ||= ["2714".hex].pack("U*")
    end

    # necessary for 1.8.7 unicode handling since many installs are on 1.8.7
    def cross
      @cross ||= ["2718".hex].pack("U*")
    end

    def blue
      bold 34
    end

    def white
      bold 39
    end

    def green
      bold 32
    end

    def gray
      bold 30
    end

    def red
      underline 31
    end

    def yellow
      underline 33
    end

    def highlight
      underline 39
    end

    def reset
      escape 0
    end

    # :beer:
    def emoji
      "\xf0\x9f\x8d\xba"
    end

    def broken_heart
      "\xF0\x9F\x92\x94"
    end

    def truncate(str)
      str.to_s[0, width - 4]
    end

    private

    def color(text)
      escape "0;#{text}"
    end

    def bold(text)
      escape "1;#{text}"
    end

    def underline(text)
      escape "4;#{text}"
    end

    def escape(text)
      "\033[#{text}m" if $stdout.tty?
    end
  end

  class Array
    def shell_s
      cp = dup
      first = cp.shift
      cp.map { |arg| arg.gsub " ", "\\ " }.unshift(first) * " "
    end
  end

  def ohai(*args)
    puts "#{Tty.blue}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
  end

  def exai(*args)
    puts "#{Tty.green}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
  end

  def warn(warning)
    puts "#{Tty.red}[WARNING]#{Tty.reset} #{warning.chomp}"
  end

  def err(error)
    puts "#{Tty.red}[FATAL]#{Tty.reset} #{error.chomp}"
  end

  def system(*args)
    abort "Failed during: #{args.shell_s}" unless Kernel.system(*args)
  end

  def sudo(*args)
    ohai "/usr/bin/sudo", *args
    system "/usr/bin/sudo", *args
  end

  # Print a warning (do this rarely)
  def opoo(warning)
    # $stderr.puts "#{Tty.yellow}Warning#{Tty.reset}: #{warning}"
    warn "#{Tty.yellow}Warning#{Tty.reset}: #{warning}"
  end

  def onoe(error)
    # $stderr.puts "#{Tty.red}Error#{Tty.reset}: #{error}"
    warn "#{Tty.red}Error#{Tty.reset}: #{error}"
  end

  def odie(error)
    onoe error
    exit 1
  end

  def pretty_installed(text)
    if !$stdout.tty?
      text
    elsif ENV["EXFILES_NO_EMOJI"]
      "#{Tty.highlight}#{Tty.green}#{text} (installed)#{Tty.reset}"
    else
      "#{Tty.highlight}#{text} #{Tty.green}#{Tty.tick}#{Tty.reset}"
    end
  end

  def pretty_uninstalled(text)
    if !$stdout.tty?
      text
    elsif ENV["EXFILES_NO_EMOJI"]
      "#{Tty.red}#{text} (uninstalled)#{Tty.reset}"
    else
      "#{text} #{Tty.red}#{Tty.cross}#{Tty.reset}"
    end
  end

  # NOTE only tested on OS X
  def getc
    system "/bin/stty raw -echo"
    if STDIN.respond_to?(:getbyte)
      STDIN.getbyte
    else
      STDIN.getc
    end
  ensure
    system "/bin/stty -raw echo"
  end

  def wait_for_user
    puts
    puts "Press RETURN to continue or any other key to abort"
    c = getc
    # we test for \r and \n because some stuff does \r instead
    abort unless [10, 13].include?(c)
  end
end
# :nocov:
