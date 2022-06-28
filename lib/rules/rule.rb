module Rules
  class Rule
    def apply(_items, _subtotal)
      raise NotImplementedError
    end
  end
end