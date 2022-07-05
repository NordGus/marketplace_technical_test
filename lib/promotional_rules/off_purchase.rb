require 'rule'

module PromotionalRules
  class OffPurchase < Rule
    def initialize(percentatge:, after: 0)
      @percentatge = (100 - percentatge) / 100.0
      @after = after
    end

    def apply(_items, subtotal)
      if subtotal >= @after
        subtotal * @percentatge
      else
        subtotal
      end
    end
  end
end