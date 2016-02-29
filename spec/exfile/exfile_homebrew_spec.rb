require "spec_helper"

RSpec.describe Exfile::Homebrew do
  subject { described_class }

  describe "when homebrew is not installed" do
    before { allow(subject).to receive(:already_installed?).and_return(false) }

    it { expect { subject.install }.to output(/Installing Homebrew, the OSX package manager/).to_stdout }
  end

  describe "when homebrew is already installed" do
    before { allow(subject).to receive(:already_installed?).and_return(true) }

    it { expect { subject.install }.to output(/Updating Homebrew/).to_stdout }
  end
end
