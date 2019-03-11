module CLI
  module Commands
    class RemCommand < BaseCommand
      def execute(env)
        if Bakery::OrderingProcess.remove_item(*args)
          render(env, code: args.first)
        else
          render_template(env, :error, message: "Cannot remove `#{args.first}` product. It does not exist in order.")
        end
      end

      def valid?
        args.size == 1 && !args[0].empty?
      end
    end
  end
end
