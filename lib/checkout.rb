require 'product'

class Checkout
  attr_reader :basket

  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @basket = []
    @subtotal = 0
  end

  def scan(item)
    @basket << Product.new(item)
  end

  def total
    @basket.each { |item| @subtotal += item.price }

    @promotional_rules.each do |rule|
      @subtotal = rule.apply(@basket, @subtotal)
    end

    "$#{(@subtotal / 100.0).round(2)}"
  end
end