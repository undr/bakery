module Bakery
  module OrderingProcess
    class Packer
      class Combinator
        attr_reader :item, :packs

        def initialize(item)
          @item = item
          @packs = item.product.packs.sort
        end

        def find
          context = catch(:done) { find_combination(Context.new(item.quantity)) }
          context.done? ? context.values : []
        end

        private

        def find_combination(context)
          throw(:done, context.done) if context.quantity.zero?

          available_packs(context.quantity).each do |pack|
            packs_quantity, quantity = context.quantity.divmod(pack.quantity)
            order_pack = Entities::PackageItem.new(quantity: packs_quantity, product_pack: pack)
            find_combination(context.next(quantity, order_pack))
          end

          context
        end

        def available_packs(quantity)
          packs.select { |pack| pack.quantity <= quantity }
        end
      end
    end
  end
end
