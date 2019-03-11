module CLI
  module Views
    class FromStdinView < ConsoleView
      def hello(_)
        strip_heredoc(
          <<-HEADER
            Read commands from console.
            Available commands: REPORT, PREPACK, RESET, REM code, ADD quantity code.
            Press Control+C for exit.

          HEADER
        )
      end

      def goodbye(_)
        "\nBye! Have a nice day.\n"
      end

      def reset(_)
        "Order is empty.\n"
      end

      def rem(locals)
        "#{locals[:code]} item was removed from order.\n"
      end

      def add(locals)
        "#{locals[:code]} item was added into order.\n"
      end

      def error(locals)
        "#{locals[:message]}\n"
      end
    end
  end
end
