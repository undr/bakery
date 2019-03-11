module CLI
  module Commands
    class ResetCommand < BaseCommand
      def execute(env)
        Bakery::OrderingProcess.reset
        render(env)
      end

      def valid?
        args.empty?
      end
    end
  end
end
