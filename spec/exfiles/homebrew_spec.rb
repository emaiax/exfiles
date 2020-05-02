# frozen_string_literal: true

require "spec_helper"

RSpec.describe Exfiles::Homebrew do
  subject { described_class }

  let(:update_msg) { /Updating Homebrew/ }
  let(:install_msg) { /Installing Homebrew, the OSX package manager/ }
  let(:bundle_msg) { /Homebrewing packages with Brewfile\.\.\. There may be some warnings/ }

  describe "checking homebrew" do
    context "when is osx" do
      before { stub_osx }

      it { expect { subject.install }.to output(install_msg).to_stdout }
    end

    context "when is linux" do
      before { stub_linux }

      it { expect { subject.install }.to output(nil).to_stdout }
    end
  end

  describe "when homebrew is not installed" do
    before { allow(described_class).to receive(:already_installed?).and_return(false) }

    it { expect { subject.install }.to output(install_msg).to_stdout }
    it { expect { subject.install }.to output(bundle_msg).to_stdout }
  end

  describe "when homebrew is already installed" do
    before { allow(described_class).to receive(:already_installed?).and_return(true) }

    it { expect { subject.install }.to output(update_msg).to_stdout }
    it { expect { subject.install }.to output(bundle_msg).to_stdout }
  end
end
