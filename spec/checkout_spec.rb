require 'spec_helper'
require './lib/checkout'
require './lib/rules/off_purchase'

describe Checkout do
  describe '#total' do
    let(:checkout) do
      Checkout.new([
                     Rules::OffPurchase.new(percentatge: 10, after: 6000)
                   ])
    end

    context "10% off client's purchase" do
      it "should add the item to the list" do
        basket = %w[001 002 003]
        co = checkout

        basket.each do |item|
          co.scan(item)
        end

        expect(co.total).to eq("$66.78")
      end
    end
  end
end
