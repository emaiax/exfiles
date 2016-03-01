require "spec_helper"

RSpec.describe Exfile::Homebrew do
  subject { described_class }

  let(:update_msg) { /Updating Homebrew/ }
  let(:install_msg) { /Installing Homebrew, the OSX package manager/ }
  let(:bundle_msg) { /Installing Homebrew packages with Brewfile\.\.\.There may be some warnings/ }

  describe "when homebrew is not installed" do
    before { allow($CHILD_STATUS).to receive(:success?).and_return(false) }

    it { expect { subject.install }.to output(install_msg).to_stdout }
    it { expect { subject.install }.to output(bundle_msg).to_stdout }
  end

  describe "when homebrew is already installed" do
    before { allow($CHILD_STATUS).to receive(:success?).and_return(true) }

    it { expect { subject.install }.to output(update_msg).to_stdout }
    it { expect { subject.install }.to output(bundle_msg).to_stdout }
  end
end
