module CLI
  module Commands
    class UnknownCommand < BaseCommand
      def execute(env)
        render_template(env, :error, message: "unknown command: #{args.first}")
      end
    end
  end
end
