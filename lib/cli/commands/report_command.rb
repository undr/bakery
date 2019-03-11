module CLI
  module Commands
    class ReportCommand < BaseCommand
      def execute(env)
        order = Bakery::OrderingProcess.get_order
        render(env, order: order)
      end

      def valid?
        args.empty?
      end
    end
  end
end
