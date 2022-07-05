require 'stock'
require 'product'

class Scanner
  def self.scan_product(code)
    product_data = Stock.find_product(code)

    raise ArgumentError, "invalid code" if product_data.nil?

    Product.new(
      code: product_data[:code],
      name: product_data[:name],
      price: product_data[:price]
    )
  end
end