module CLI
  module Commands
    class PrepackCommand < BaseCommand
      def execute(env)
        order = Bakery::OrderingProcess.get_order
        packages = Bakery::OrderingProcess.prepack(order)

        render(env, packages: packages)
      end

      def valid?
        args.empty?
      end
    end
  end
end
