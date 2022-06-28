require 'stock'

class Product
  attr_reader :code, :name, :price

  def initialize(code)
    product_data = Stock.products[code]

    @code = product_data[:code]
    @name = product_data[:name]
    @price = product_data[:price]
  end

  def update_price(new_price)
    @price = new_price
  end
end