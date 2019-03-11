RSpec.describe CLI::Commands::ResetCommand do
  subject(:command) { described_class.new(:reset, args) }

  let(:view) { CLI::Views::TestView.new }
  let(:output) { StringIO.new }
  let(:env) { CLI::Environment.new(output: output, view: view) }
  let(:args) { [] }

  describe "#valid?" do
    context "valid command" do
      let(:args) { [] }
      it { is_expected.to be_valid }
    end

    context "with args" do
      let(:args) { ["XXL"] }
      it { is_expected.to_not be_valid }
    end
  end

  describe "#execute" do
    subject(:execute) { command.execute(env) }

    context "in isolation" do
      it "resets an order" do
        expect(Bakery::OrderingProcess).to receive(:reset)
        execute
        output.rewind
        expect(output.read).to eq("reset\n")
      end
    end
  end
end
