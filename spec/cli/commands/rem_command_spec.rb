RSpec.describe CLI::Commands::RemCommand do
  subject(:command) { described_class.new(:rem, args) }

  let(:view) { CLI::Views::TestView.new }
  let(:output) { StringIO.new }
  let(:env) { CLI::Environment.new(output: output, view: view) }
  let(:args) { ["XXL"] }

  describe "#valid?" do
    context "valid command" do
      let(:args) { ["XXL"] }
      it { is_expected.to be_valid }
    end

    context "with empty arg" do
      let(:args) { [""] }
      it { is_expected.to_not be_valid }
    end

    context "without args" do
      let(:args) { [] }
      it { is_expected.to_not be_valid }
    end

    context "with two args" do
      let(:args) { ["XXL", "LXX"] }
      it { is_expected.to_not be_valid }
    end
  end

  describe "#execute" do
    subject(:execute) { command.execute(env) }

    context "in isolation" do
      it "removes one item from an order" do
        expect(Bakery::OrderingProcess).to receive(:remove_item).with("XXL").and_return(true)
        execute
        output.rewind
        expect(output.read).to eq("rem: [\"XXL\"]\n")
      end

      it "prints an error if product does not exist in order" do
        expect(Bakery::OrderingProcess).to receive(:remove_item).with("XXL").and_return(false)
        execute
        output.rewind
        expect(output.read).to eq("error: [\"Cannot remove `XXL` product. It does not exist in order.\"]\n")
      end
    end
  end
end
