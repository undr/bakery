RSpec.describe CLI::Commands do
  subject(:parse) { described_class.parse(command_line) }

  let(:command_line) { "RepoRT" }

  describe ".parse" do
    context "report command" do
      it { is_expected.to eq(CLI::Commands::ReportCommand.new("report", [])) }
    end

    context "prepack command" do
      let(:command_line) { "pRePack" }
      it { is_expected.to eq(CLI::Commands::PrepackCommand.new("prepack", [])) }
    end

    context "reset command" do
      let(:command_line) { "ReSet" }
      it { is_expected.to eq(CLI::Commands::ResetCommand.new("reset", [])) }
    end

    context "rem command" do
      let(:command_line) { "Rem ABC1" }
      it { is_expected.to eq(CLI::Commands::RemCommand.new("rem", ["ABC1"])) }
    end

    context "add command" do
      let(:command_line) { "aDd 10 ABC1" }
      it { is_expected.to eq(CLI::Commands::AddCommand.new("add", ["ABC1", 10])) }
    end

    context "empty command" do
      let(:command_line) { "" }
      it { is_expected.to eq(CLI::Commands::BaseCommand.new("noop", [])) }
    end

    context "invalid command" do
      let(:command_line) { "add" }
      it { is_expected.to eq(CLI::Commands::UnknownCommand.new("unknown", ["add"])) }
    end

    context "unknown command" do
      let(:command_line) { "blah blah blah" }
      it { is_expected.to eq(CLI::Commands::UnknownCommand.new("unknown", ["blah blah blah"])) }
    end
  end
end
