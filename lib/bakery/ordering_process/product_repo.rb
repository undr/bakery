module Bakery
  module OrderingProcess
    class ProductRepo
      class << self
        def load(from:)
          new.tap do |repo|
            File.open(from, File::RDONLY) do |io|
              io.each do |line|
                data = JSON.parse(line.strip)
                repo.put(Entities::Product.new(data))
              end
            end
          end
        end

        def save(repo, into:)
          case into
          when String
            File.open(into, File::WRONLY | File::TRUNC | File::CREAT) do |file|
              write(repo, into: file)
            end
          when IO
            write(repo, into: into)
          end
        end

        private

        def write(repo, into:)
          repo.each do |product|
            into.write("#{product.to_json}\n")
          end
        end
      end

      def codes
        @items.keys
      end

      def each(&block)
        items.values.each(&block)
      end

      def autocomplete_codes(start)
        codes.select { |code| code.downcase.start_with?(start.downcase) }
      end

      def put(product)
        items[product.code] = product
      end

      alias_method :<<, :put

      def get(code)
        items[code]
      end

      def get!(code)
        items.key?(code) ? items[code] : (raise NotFoundError.new(code))
      end

      private

      def items
        @items ||= {}
      end
    end
  end
end
