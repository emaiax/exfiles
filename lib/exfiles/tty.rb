module Exfiles
  module Tty
    extend self

    def tick
      # necessary for 1.8.7 unicode handling since many installs are on 1.8.7
      @tick ||= ["2714".hex].pack("U*")
    end

    def cross
      # necessary for 1.8.7 unicode handling since many installs are on 1.8.7
      @cross ||= ["2718".hex].pack("U*")
    end

    def blue;      bold 34;      end
    def white;     bold 39;      end
    def green;     bold 32;      end
    def gray;      bold 30;      end
    def red;       underline 31; end
    def yellow;    underline 33; end
    def highlight; underline 39; end

    def reset;     escape 0;     end

    # :beer:
    def emoji; "\xf0\x9f\x8d\xba"; end

    def truncate(str); str.to_s[0, width - 4]; end

    private

    def color(n);     escape "0;#{n}"; end
    def bold(n);      escape "1;#{n}"; end
    def underline(n); escape "4;#{n}"; end

    def escape(n); "\033[#{n}m" if $stdout.tty?; end
  end

  class Array
    def shell_s
      cp = dup
      first = cp.shift
      cp.map{ |arg| arg.gsub " ", "\\ " }.unshift(first) * " "
    end
  end

  def ohai *args
    puts "#{Tty.blue}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
  end

  def exai *args
    puts "#{Tty.green}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
  end

  def warn warning
    puts "#{Tty.red}[WARNING]#{Tty.reset} #{warning.chomp}"
  end

  def err error
    puts "#{Tty.red}[FATAL]#{Tty.reset} #{error.chomp}"
  end

  def system *args
    abort "Failed during: #{args.shell_s}" unless Kernel.system(*args)
  end

  def sudo *args
    ohai "/usr/bin/sudo", *args
    system "/usr/bin/sudo", *args
  end

  # Print a warning (do this rarely)
  def opoo(warning)
    $stderr.puts "#{Tty.yellow}Warning#{Tty.reset}: #{warning}"
  end

  def onoe(error)
    $stderr.puts "#{Tty.red}Error#{Tty.reset}: #{error}"
  end

  def odie(error)
    onoe error
    exit 1
  end

  def pretty_installed(f)
    if !$stdout.tty?
      "#{f}"
    elsif ENV["EXFILES_NO_EMOJI"]
      "#{Tty.highlight}#{Tty.green}#{f} (installed)#{Tty.reset}"
    else
      "#{Tty.highlight}#{f} #{Tty.green}#{Tty.tick}#{Tty.reset}"
    end
  end

  def pretty_uninstalled(f)
    if !$stdout.tty?
      "#{f}"
    elsif ENV["EXFILES_NO_EMOJI"]
      "#{Tty.red}#{f} (uninstalled)#{Tty.reset}"
    else
      "#{f} #{Tty.red}#{Tty.cross}#{Tty.reset}"
    end
  end

  def getc  # NOTE only tested on OS X
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
    abort unless c == 13 or c == 10
  end
end
