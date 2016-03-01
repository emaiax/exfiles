require "spec_helper"

RSpec.describe Exfile::Xcode do
  subject { described_class }

  let(:installed_msg) { /Xcode is already installed. The show must go on/ }
  let(:not_installed_msg) { /Xcode must be installed to proceed./ }

  describe "when xcode is not installed" do
    before { allow(Dir).to receive(:exist?).and_return(false) }

    it { expect { subject.install }.to output(not_installed_msg).to_stdout }
  end

  describe "when xcode is already installed" do
    before { allow(Dir).to receive(:exist?).and_return(true) }

    it { expect { subject.install }.to output(installed_msg).to_stdout }
  end
end
