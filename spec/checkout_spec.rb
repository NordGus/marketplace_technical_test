require 'spec_helper'
require './lib/checkout'
require './lib/rules/off_purchase'
require './lib/rules/product_amount_offer'

describe Checkout do
  describe '#total' do
    let(:checkout) do
      Checkout.new([
                     Rules::ProductAmountOffer.new(product_code: "001", new_price: 850, after_amount: 2),
                     Rules::OffPurchase.new(percentatge: 10, after: 6000)
                   ])
    end

    context "10% off client's purchase" do
      it "it should apply 10% off the client's total purchase" do
        basket = %w[001 002 003]
        co = checkout

        basket.each do |item|
          co.scan(item)
        end

        expect(co.total).to eq("$66.78")
      end
    end

    context "client buys buy 2 lavender hearts" do
      it "it should apply new price of $8.50 to each lavender heart on the basket" do
        basket = %w[001 003 001]
        co = checkout

        basket.each do |item|
          co.scan(item)
        end

        expect(co.total).to eq("$36.95")
      end
    end

    context "both offers" do
      it "it should apply new price of $8.50 to each lavender heart on the basket and apply 10% off the client's total purchase" do
        basket = %w[001 002 001 003]
        co = checkout

        basket.each do |item|
          co.scan(item)
        end

        expect(co.total).to eq("$73.76")
      end
    end
  end
end
