require "spec_helper"

RSpec.describe Exfiles::Base do
  let(:cmd_msg)     { "[Running] ls .\n" }
  let(:welcome_msg) { /Welcome to EXFILES Installation/ }
  let(:success_msg) { /EXFILES has been yup. Please restart your terminal and vim/ }

  let(:fail_msgs) do
    [
      /We're very sorry, but EXFILES couldn't be installed at this time/,
      /Please open an issue on Github following the link bellow/,
      %r{https:\/\/github\.com\/emaiax\/dotfiles\/issues\/new\?labels=bug&title=\[E0\.1\.0\]%20no%20reason}
    ]
  end

  describe "base" do
    context "on linux" do
      before { stub_const("Object::RUBY_PLATFORM", "x86_64-linux") }

      it { expect(subject).to_not be_osx }
    end

    context "on osx" do
      before { stub_const("Object::RUBY_PLATFORM", "x86_64-darwin14") }

      it { expect(subject).to be_osx }
    end

    it { expect { subject.run("ls .") }.to output(cmd_msg).to_stdout }
    it { expect { subject.welcome_msg }.to output(welcome_msg).to_stdout }
    it { expect { subject.success_msg("yup") }.to output(success_msg).to_stdout }

    it { expect { subject.fail_msg("no reason") }.to output(fail_msgs[0]).to_stdout }
    it { expect { subject.fail_msg("no reason") }.to output(fail_msgs[1]).to_stdout }
    it { expect { subject.fail_msg("no reason") }.to output(fail_msgs[2]).to_stdout }
  end
end
