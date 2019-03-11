module Bakery
  module OrderingProcess
    module Entities
      class Order
        def initialize(items = [])
          @collection = items.inject({}) { |memo, item| memo.merge(item.code => item) }
        end

        def items
          collection.values
        end

        def empty?
          items.empty?
        end

        def has?(code)
          collection.key?(code)
        end

        def add(item)
          code = item.code

          if collection.key?(code)
            collection[code].merge!(item)
          else
            collection[code] = item
          end
        end

        def remove(code)
          collection.delete(code)
        end

        private

        attr_reader :collection
      end
    end
  end
end
