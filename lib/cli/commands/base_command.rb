module CLI
  module Commands
    class BaseCommand
      attr_reader :name, :args

      def initialize(name, args)
        @name = name.to_sym
        @args = args
      end

      def valid?
        # TODO: Implement validation of commands
        true
      end

      def execute(env)
      end

      def equal?(other)
        name == other.name && args == other.args
      end

      alias_method :==, :equal?
      alias_method :eql?, :equal?

      private

      def render(env, locals = {})
        render_template(env, name, locals)
      end

      def render_template(env, template_name, locals = {})
        env.output.write(env.view.render(template_name, locals))
      end
    end
  end
end
