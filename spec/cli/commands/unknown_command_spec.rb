RSpec.describe CLI::Commands::UnknownCommand do
  let(:command) { described_class.new(:unknown, args) }
  let(:view) { CLI::Views::TestView.new }
  let(:output) { StringIO.new }
  let(:env) { CLI::Environment.new(output: output, view: view) }
  let(:args) { ["blah"] }

  describe "#execute" do
    subject(:execute) { command.execute(env) }

    it "renders an error" do
      execute
      output.rewind
      expect(output.read).to eq("error: [\"unknown command: blah\"]\n")
    end
  end
end
