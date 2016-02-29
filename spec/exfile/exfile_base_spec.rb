require "spec_helper"

RSpec.describe Exfile::Base do
  let(:subject) { Class.new { extend Exfile::Base } }

  let(:cmd_msg)     { "[Running] ls .\n" }
  let(:welcome_msg) { /Welcome to EXFILES Installation/ }
  let(:success_msg) { /EXFILES has been yup. Please restart your terminal and vim/ }

  describe "base" do
    it { expect(subject).to be_osx }

    it { expect { subject.run("ls .") }.to output(cmd_msg).to_stdout }
    it { expect { subject.welcome_msg }.to output(welcome_msg).to_stdout }
    it { expect { subject.success_msg("yup") }.to output(success_msg).to_stdout }
  end
end
