module CLI
  class OptsParser
    class << self
      def parse(input)
        options = {}
        spec = OptionParser.new do |opts|
          opts.banner = "Usage: bakery --repo=FILENAME [INPUT]"
          opts.on("-rFILENAME", "--repo=FILENAME", "Bakery's data file") do |filename|
            options[:datafile] = filename
          end

          opts.on("-d", "--dev", "Run into development mode") do |filename|
            options[:development] = true
          end

          opts.on("-h", "--help", "Prints this help") do
            options[:help] = opts.to_s
          end
        end

        process(spec, input.dup, options).tap do |opts|
          validate!(opts)
        end
      end

      private

      def process(spec, input, options)
        spec.parse!(input)
        options[:input] = input.first
        options
      end

      def validate!(options)
        return if options[:help]
        raise OptionParser::MissingArgument.new("--repo") unless options.has_key?(:datafile)
      end
    end
  end
end
