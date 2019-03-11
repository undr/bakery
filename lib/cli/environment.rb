module CLI
  class Environment
    attr_reader :input, :output, :view

    def initialize(options)
      @view = build_view(options)
      @input = build_input(options)
      @output = build_output(options)
      @readline = build_readline(options)
      @development = options[:development]
    end

    def development?
      @development
    end

    def each_line(prompt, &block)
      use_readline? ? readline(prompt, &block) : input.each_line(&block)
    end

    def readline(prompt)
      Readline.input = input
      while line = Readline.readline(prompt, true) do
        yield line
      end
    end

    private

    def use_readline?
      @readline
    end

    def use_stdin?(options)
      options[:input].nil?
    end

    def build_readline(options)
      options.fetch(:readline, use_stdin?(options))
    end

    def build_input(options)
      use_stdin?(options) ? $stdin : open_file(options[:input])
    end

    def build_view(options)
      options.fetch(:view, default_view(options))
    end

    def default_view(options)
      use_stdin?(options) ? Views::FromStdinView.new : Views::FromFileView.new
    end

    def build_output(options)
      options[:output].nil? ? $stdout : options[:output]
    end

    def open_file(filename)
      File.open(File.absolute_path(filename), File::RDONLY)
    end
  end
end
