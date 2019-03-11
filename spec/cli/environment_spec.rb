RSpec.describe CLI::Environment do
  subject(:init) { described_class.new(options) }

  let(:options) { { } }

  describe "#initialize" do
    its(:input) { is_expected.to eq($stdin) }
    its(:output) { is_expected.to eq($stdout) }
    its(:view) { is_expected.to be_instance_of(CLI::Views::FromStdinView) }

    context "when input is defined" do
      let(:options) { { input: "./spec/fixtures/commands/general_case" } }

      its(:input) { is_expected.to be_instance_of(File) }
      it { expect(subject.input.path).to eq(File.absolute_path("./spec/fixtures/commands/general_case")) }
      its(:output) { is_expected.to eq($stdout) }
      its(:view) { is_expected.to be_instance_of(CLI::Views::FromFileView) }
    end

    context "when output is defined" do
      let(:output) { StringIO.new }
      let(:options) { { output: output } }

      its(:input) { is_expected.to eq($stdin) }
      its(:output) { is_expected.to eq(output) }
      its(:view) { is_expected.to be_instance_of(CLI::Views::FromStdinView) }
    end
  end
end
