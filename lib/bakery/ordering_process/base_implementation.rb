module Bakery
  module OrderingProcess
    class BaseImplementation
      attr_reader :repo

      def initialize(repo)
        @repo = repo
      end

      def version
        VERSION
      end

      def get_order
        @order ||= Entities::Order.new
      end

      def prepack(order)
        Packer.new(order).prepack
      end

      def reset
        @order = Entities::Order.new
      end

      def add_item(code, quantity)
        product = repo.get(code)
        return false unless product

        item = Entities::OrderItem.new(product: product, quantity: quantity)
        get_order.add(item)
      end

      def remove_item(code)
        order = get_order
        order.has?(code) ? order.remove(code) : false
      end
    end
  end
end
