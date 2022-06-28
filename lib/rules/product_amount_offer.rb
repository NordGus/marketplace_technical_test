require 'rules/rule'

module Rules
  class ProductAmountOffer < Rule
    def initialize(product_code:, new_price:, after_amount: 0)
      @product_code = product_code
      @new_price = new_price
      @after_amount = after_amount
    end

    def apply(items, subtotal)
      products = items.select { |item| item.code == @product_code }

      return subtotal if products.length < @after_amount

      subtotal = 0

      items.each do |item|
        item.update_price(@new_price) if item.code == @product_code
        subtotal += item.price
      end

      subtotal
    end
  end
end