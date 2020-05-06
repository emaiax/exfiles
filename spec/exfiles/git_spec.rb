# frozen_string_literal: true

require "spec_helper"

RSpec.describe Exfiles::Git do
  let(:command) do
    <<~HEREDOC

      Downloading submodules... please wait.

      [Running] cd ~/.dotfiles
      [Running] git submodule update --recursive
      [Running] git clean -df

    HEREDOC
  end

  describe "git" do
    it { expect { subject.install_or_update }.to output(command).to_stdout }
  end
end
