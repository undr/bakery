module CLI
  module Views
    class ConsoleView < BaseView
      def report(locals)
        return "" unless locals[:order]
        return "Empty order\n" if locals[:order].empty?

        "".tap do |out|
          locals[:order].items.each do |item|
            out << "#{item.quantity}\t#{item.code}\t#{item.product.name}\n"
          end

          out << "\n"
        end
      end

      def prepack(locals)
        return "" unless locals[:packages]
        return "We cannot pack empty order\n" if locals[:packages].empty?

        "".tap do |out|
          out << "WARNING! We cannot pack all products.\n" unless locals[:packages].valid?
          out << locals[:packages].map(&method(:format_package)).join("\n")
          out << "\n"
        end
      end

      private

      def format_package(package)
        [].tap do |out|
          if package.valid?
            out << [package.quantity, package.code, format_money(package.total_cents)].join("\t")
            out.concat(package.items.map(&method(:format_package_item)))
          else
            out << [package.quantity, package.code].join("\t")
            out << "\tWe cannot pack this order item."
            out << "\tPlease, increase or reduce quantity of the product."
          end
        end
      end

      def format_package_item(item)
        quantity = item.product_pack.quantity
        price_cents = item.product_pack.price_cents
        "\t#{item.quantity} x #{quantity}\t#{format_money(price_cents)}"
      end

      def format_money(cents)
        "$#{cents / 100.0}"
      end
    end
  end
end
