module CLI
  module Views
    class BaseView
      def render(name, locals = {})
        if respond_to?(name)
          send(name, locals)
        else
          default_template
        end
      end

      private

      def default_template
      end

      def strip_heredoc(string)
        string.gsub(/^#{string.scan(/^[ \t]*(?=\S)/).min}/, "").tap do |stripped|
          stripped.freeze if string.frozen?
        end
      end
    end
  end
end
