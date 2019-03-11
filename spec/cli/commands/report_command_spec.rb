RSpec.describe CLI::Commands::ReportCommand do
  subject(:command) { described_class.new(:report, args) }

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
      it "renders an order" do
        expect(Bakery::OrderingProcess).to receive(:get_order).and_return("order")
        execute
        output.rewind
        expect(output.read).to eq("report: [\"order\"]\n")
      end
    end
  end
end
