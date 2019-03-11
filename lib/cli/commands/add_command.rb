module CLI
  module Commands
    class AddCommand < BaseCommand
      def execute(env)
        if Bakery::OrderingProcess.add_item(*args)
          render(env, code: args[0], quantity: args[1])
        else
          render_template(env, :error, message: "Cannot add `#{args.first}` product. It does not exist in the store.")
        end
      end

      def valid?
        args.size == 2 && args[1].is_a?(Integer) && !args[0].empty?
      end
    end
  end
end
