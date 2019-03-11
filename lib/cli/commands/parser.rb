module CLI
  module Commands
    class Parser
      COMMANDS = %w(report prepack reset rem add).freeze
      COMMAND_REGEXP = (/^(?<command>#{COMMANDS.join("|")})(?<args>\s+\d+\s*\w+|\s+\w+)?$/i).freeze
      ARGS_REGEXP = /(\d*)(?:\s*(\w*))/.freeze

      def initialize(command_line)
        @command_line = command_line
      end

      def parse
        if (matches = COMMAND_REGEXP.match(command_line.strip))
          command = build(
            matches[:command].downcase,
            parse_arguments((matches[:args] || "").strip)
          )
          command.valid? ? command : unknown_command
        else
          unknown_command
        end
      end

      private

      attr_reader :command_line

      def unknown_command
        if command_line.strip.empty?
          BaseCommand.new(:noop, [])
        else
          UnknownCommand.new(:unknown, [command_line])
        end
      end

      def parse_arguments(args)
        return [] if args.empty?

        matches = ARGS_REGEXP.match(args)

        if matches[1].empty?
          [matches[2]]
        else
          [matches[2], matches[1].to_i]
        end
      end

      def build(name, args)
        Commands.const_get("#{name.capitalize}Command").new(name, args)
      end
    end
  end
end
