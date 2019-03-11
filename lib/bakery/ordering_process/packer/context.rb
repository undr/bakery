module Bakery
  module OrderingProcess
    class Packer
      class Context
        attr_reader :quantity, :values

        def initialize(quantity)
          @quantity = quantity
          @values = []
          @done = false
        end

        def next(quantity, value)
          instance = clone
          instance.instance_eval do
            @quantity = quantity
            @values << value
          end

          instance
        end

        def done?
          @done
        end

        def done
          instance = clone
          instance.instance_eval { @done = true }
          instance
        end

        private

        def initialize_clone(other)
          @done = other.done?
          @quantity = other.quantity
          @values = other.values.clone
        end
      end
    end
  end
end
