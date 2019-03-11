module CLI
  class Runner
    extend Forwardable

    def_delegators :env, :view, :output

    def initialize(env)
      @env = env
    end

    def run
      output.write(view.render(:hello))

      env.each_line("(#{bakery_version})> ") do |line|
        rescue_exceptions do
          command = Commands.parse(line)
          command.execute(env)
        end
      end
    rescue Interrupt
      output.write(view.render(:goodbye))
      exit(true)
    end

    private

    attr_reader :env

    def rescue_exceptions(&block)
      if env.development?
        block.call
      else
        begin
          block.call
        rescue Bakery::Error => e
          output.write(view.render(:error, message: "Error: #{e.message}"))
        rescue => e
          output.write(view.render(:error, message: "Unknown error."))
        end
      end
    end

    def bakery_version
      Bakery::OrderingProcess.version
    end
  end
end
