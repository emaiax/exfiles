# frozen_string_literal: true

require "spec_helper"

RSpec.describe Exfiles::Base do
  let(:cmd_msg)     { "[Running] ls .\n" }
  let(:welcome_msg) { /Welcome to EXFILES Installation/ }
  let(:success_msg) { /EXFILES has been installed successfully\. Please restart your terminal and vim/ }

  let(:fail_msgs) { /We're very sorry, EXFILES couldn't be installed at this time/ }

  describe "base" do
    context "on osx" do
      before { stub_osx }

      it { expect(subject).to be_osx }
    end

    context "on linux" do
      before { stub_linux }

      it { expect(subject).to_not be_osx }
    end

    it { expect { subject.run("ls .") }.to output(cmd_msg).to_stdout }

    it { expect { subject.welcome }.to output(welcome_msg).to_stdout }
    it { expect { subject.success }.to output(success_msg).to_stdout }

    it { expect { subject.fail("no reason") }.to output(fail_msgs).to_stdout }
  end
end
