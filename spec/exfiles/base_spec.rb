# frozen_string_literal: true

require "spec_helper"

RSpec.describe Exfiles::Base do
  let(:cmd_msg)     { "[Running] ls .\n" }
  let(:welcome_msg) { /Welcome to EXFILES Installation/ }
  let(:success_msg) { /EXFILES has been successfully installed to/ }

  let(:fail_msgs) { /We're very sorry, EXFILES couldn't be installed at this time/ }

  describe "ask" do
    context "auto install" do
      it { expect(subject.ask_to_install("whatever")).to be_truthy }
    end

    context "ask to install" do
      before { ENV["ASK"] = "true" }
      before { allow(STDIN).to receive(:gets) { "y" } }

      it { expect(subject.ask_to_install("whatever")).to be_truthy }

      after { ENV["ASK"] = nil }
    end
  end

  describe "base" do
    context "on osx" do
      before { stub_osx }

      it { expect(subject).to be_osx }
      it { expect(subject).to_not be_linux }
    end

    context "on linux" do
      before { stub_linux }

      it { expect(subject).to_not be_osx }
      it { expect(subject).to be_linux }
    end

    it { expect { subject.run("ls .") }.to output(cmd_msg).to_stdout }

    it { expect { subject.welcome }.to output(welcome_msg).to_stdout }
    it { expect { subject.success }.to output(success_msg).to_stdout }

    it { expect { subject.fail("no reason") }.to output(fail_msgs).to_stdout }
  end
end
