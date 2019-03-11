module Bakery
  module OrderingProcess
    module Entities
      class Packages < Array
        def initialize(items = [])
          super(items).freeze
        end

        def valid?
          all?(&:valid?)
        end
      end
    end
  end
end
