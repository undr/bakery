RSpec.describe CLI::Runner do
  subject(:output) { StringIO.new }

  let(:repo) { Bakery::OrderingProcess::ProductRepo.load(from: "./spec/fixtures/datafile") }
  let(:runner) { described_class.new(env) }
  let(:view) { CLI::Views::FromFileView.new }
  let(:env) { CLI::Environment.new(input: "./spec/fixtures/commands/#{commandfile}", output: output, view: view) }
  let(:commandfile) { "general_case" }
  let(:example_response) do
    File.read(File.absolute_path("spec/fixtures/responses/#{response_name}"))
  end

  before do
    @old_implementation = Bakery::OrderingProcess.implementation
    Bakery::OrderingProcess.implementation = Bakery::OrderingProcess::BaseImplementation.new(repo)
  end

  after { Bakery::OrderingProcess.implementation = @old_implementation }

  describe "#run" do
    before do
      runner.run
      output.rewind
    end

    context "general set of commands with FromFileView view" do
      let(:response_name) { "general_case_from_file" }

      its(:read) { is_expected.to eq(example_response)}
    end

    context "with errors and FromFileView view" do
      let(:commandfile) { "with_errors" }
      let(:response_name) { "with_errors_from_file" }

      its(:read) { is_expected.to eq(example_response)}
    end

    context "general set of commands with FromStdinView view" do
      let(:response_name) { "general_case_from_stdin" }
      let(:view) { CLI::Views::FromStdinView.new }

      its(:read) { is_expected.to eq(example_response)}
    end

    context "with errors and FromStdinView view" do
      let(:commandfile) { "with_errors" }
      let(:response_name) { "with_errors_from_stdin" }
      let(:view) { CLI::Views::FromStdinView.new }

      its(:read) { is_expected.to eq(example_response)}
    end
  end
end
