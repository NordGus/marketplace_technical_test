class Stock
  def self.find_product(code)
    products = {
      '001' => { code: '001', name: 'Lavender heart', price: 925 },
      '002' => { code: '002', name: 'Personalised cufflinks', price: 4500 },
      '003' => { code: '003', name: 'Kids T-shirt', price: 1995 }
    }

    products[code]
  end
end