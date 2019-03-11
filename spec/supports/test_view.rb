module CLI
  module Views
    class TestView < CLI::Views::BaseView
      def hello(_)
        "header\n"
      end

      def prepack(locals)
        "prepack: #{locals.values.inspect}\n"
      end

      def report(locals)
        "report: #{locals.values.inspect}\n"
      end

      def reset(_)
        "reset\n"
      end

      def rem(locals)
        "rem: #{locals.values.inspect}\n"
      end

      def add(locals)
        "add: #{locals.values.inspect}\n"
      end

      def error(locals)
        "error: #{locals.values.inspect}\n"
      end
    end
  end
end
