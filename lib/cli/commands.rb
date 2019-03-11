require_relative "./commands/parser"
require_relative "./commands/base_command"
require_relative "./commands/add_command"
require_relative "./commands/rem_command"
require_relative "./commands/reset_command"
require_relative "./commands/report_command"
require_relative "./commands/prepack_command"
require_relative "./commands/unknown_command"

module CLI
  module Commands
    module_function

    def parse(command_line)
      Parser.new(command_line).parse
    end
  end
end
