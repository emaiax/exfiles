module Exfiles
  module Git
    extend Base
    extend self

    def install_or_update
      puts
      puts "Downloading submodules... please wait."
      puts ""

      run "cd #{Exfiles.path}"
      run "git submodule update --recursive"
      run "git clean -df"

      puts ""
    end
  end
end
