require 'spec_helper'
require './lib/checkout'
require './lib/promotional_rules/off_purchase'
require './lib/promotional_rules/product_amount_offer'

describe Checkout do
  describe "#scan" do
    let(:checkout) { Checkout.new }

    context "succeeds" do
      it "it should add the required product to the basket" do
        co = checkout
        co.scan("001")

        basket = co.basket

        expect(basket.length).to eq(1)
        expect(basket.first.code).to eq("001")
        expect(basket.first.name).to eq("Lavender heart")
        expect(basket.first.price).to eq(925)
      end
    end

    context "fails" do
      it "it should raise an argument exception" do
        co = checkout
        expect { co.scan("bad_code") }.to raise_error(ArgumentError, "invalid code")
      end
    end
  end

  describe '#total' do
    let(:checkout) do
      Checkout.new([
                     PromotionalRules::ProductAmountOffer.new(product_code: "001", new_price: 850, after_amount: 2),
                     PromotionalRules::OffPurchase.new(percentatge: 10, after: 6000)
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

    context "client buys buy 2 lavender hearts and buys more than $60" do
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
