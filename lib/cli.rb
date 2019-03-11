require "pp"
require "optparse"
require "readline"
require "forwardable"

require_relative "cli/views"
require_relative "cli/environment"
require_relative "cli/commands"
require_relative "cli/opts_parser"
require_relative "cli/runner"
require_relative "bakery"

module CLI
  module_function

  def run(args)
    options = CLI::OptsParser.parse(args)

    if options.has_key?(:help)
      puts options[:help]
      exit(true)
    end

    repo = Bakery::OrderingProcess::ProductRepo.load(from: options[:datafile])
    Bakery::OrderingProcess.implementation = Bakery::OrderingProcess::BaseImplementation.new(repo)

    Readline.completion_proc = -> (input) do
      Bakery::OrderingProcess.repo.autocomplete_codes(input)
    end

    env = Environment.new(options)

    CLI::Runner.new(env).run
  end
end
