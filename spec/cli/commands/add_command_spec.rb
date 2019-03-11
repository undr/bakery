RSpec.describe CLI::Commands::AddCommand do
  subject(:command) { described_class.new(:add, args) }

  let(:view) { CLI::Views::TestView.new }
  let(:output) { StringIO.new }
  let(:env) { CLI::Environment.new(output: output, view: view) }
  let(:args) { ["XXL", 10] }

  describe "#valid?" do
    context "valid command" do
      let(:args) { ["XXL", 10] }
      it { is_expected.to be_valid }
    end

    context "without args" do
      let(:args) { [] }
      it { is_expected.to_not be_valid }
    end

    context "with only one arg" do
      let(:args) { ["XXL"] }
      it { is_expected.to_not be_valid }
    end

    context "with two strings" do
      let(:args) { ["XXL", "LXX"] }
      it { is_expected.to_not be_valid }
    end
  end

  describe "#execute" do
    subject(:execute) { command.execute(env) }

    context "in isolation" do
      it "adds one item into an order" do
        expect(Bakery::OrderingProcess).to receive(:add_item).with("XXL", 10).and_return(true)
        execute
        output.rewind
        expect(output.read).to eq("add: [\"XXL\", 10]\n")
      end

      it "prints an error if product does not exist in repo" do
        expect(Bakery::OrderingProcess).to receive(:add_item).with("XXL", 10).and_return(false)
        execute
        output.rewind
        expect(output.read).to eq("error: [\"Cannot add `XXL` product. It does not exist in the store.\"]\n")
      end
    end
  end
end
