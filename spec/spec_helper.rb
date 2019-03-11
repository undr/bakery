require "rspec/its"
require "rspec/collection_matchers"

require_relative "../lib/cli"
require_relative "./supports/test_view"
require_relative "./supports/test_implementation"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with :rspec
  config.mock_with :rspec
  config.order = :random

  config.around(bakery: true) do |example|
    @old_implementation = Bakery::OrderingProcess.implementation
    Bakery::OrderingProcess.implementation = TestImplementation.new
    example.run
    Bakery::OrderingProcess.implementation = @old_implementation
  end
end
