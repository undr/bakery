RSpec.describe CLI::OptsParser do
  subject(:parse) { described_class.parse(args) }

  let(:args) { ["-h"] }
  let(:help_message) do
    <<-MSG
Usage: bakery --repo=FILENAME [INPUT]
    -r, --repo=FILENAME              Bakery's data file
    -d, --dev                        Run into development mode
    -h, --help                       Prints this help
    MSG
  end

  describe ".parse" do
    context "when -h option is present" do
      it { is_expected.to eq(help: help_message, input: nil)}
    end

    context "when --help option is present" do
      let(:args) { ["--help"] }

      it { is_expected.to eq(help: help_message, input: nil)}
    end

    context "when -d option is present" do
      let(:args) { ["-r", "./filename", "-d"] }
      it { is_expected.to eq(datafile: "./filename", input: nil, development: true)}
    end

    context "when --dev option is present" do
      let(:args) { ["-r", "./filename", "--dev"] }

      it { is_expected.to eq(datafile: "./filename", input: nil, development: true)}
    end

    context "when -r option is present" do
      let(:args) { ["-r", "./filename"] }

      it { is_expected.to eq(datafile: "./filename", input: nil)}
    end

    context "when --repo option is present" do
      let(:args) { ["--repo", "./filename"] }

      it { is_expected.to eq(datafile: "./filename", input: nil)}
    end

    context "when --repo doesn't have an argument" do
      let(:args) { ["--repo"] }

      it "raises an exception" do
        expect { parse }.to raise_error(OptionParser::MissingArgument, "missing argument: --repo")
      end
    end

    context "when -r doesn't have an argument" do
      let(:args) { ["-r"] }

      it "raises an exception" do
        expect { parse }.to raise_error(OptionParser::MissingArgument, "missing argument: -r")
      end
    end

    context "when --repo or -r option is absent" do
      let(:args) { [] }

      it "raises an exception" do
        expect { parse }.to raise_error(OptionParser::MissingArgument, "missing argument: --repo")
      end
    end

    context "with input" do
      let(:args) { ["-r", "./storefile", "./inputfile"] }

      it { is_expected.to eq(datafile: "./storefile", input: "./inputfile")}
    end

    context "with inputs" do
      let(:args) { ["-r", "./storefile", "./inputfile1", "./inputfile2"] }

      it { is_expected.to eq(datafile: "./storefile", input: "./inputfile1")}
    end
  end
end
