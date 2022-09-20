require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before (:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @item5 = Item.new({name: 'Onion', price: '$0.25'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@market).to be_instance_of(Market)
    end

    it 'has a name' do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
    end

    it 'has no vendors to start' do
      expect(@market.vendors).to eq([])
    end

    it 'has a date' do
      allow(@market).to receive(:date).and_return("24/02/2020")
      expect(@market.date).to eq("24/02/2020")
    end
  end

  describe '#add_vendor' do
    it 'can add vendors to the market' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end
  
  describe '#vendor_names' do
  it 'returns an array of the vendors names' do   
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end
end

describe '#vendors_that_sell' do
  it 'returns array of vendors that sell the given item' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#total_inventory' do
    it 'returns hash with every item and its quantity and vendors' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @vendor3.stock(@item3, 10)
      
      total_inventory_items = {
        @item1 => {
          quantity: 100,
          vendors: [@vendor1, @vendor3]
        },
        @item2 => {
          quantity: 7,
          vendors: [@vendor1]
        },
        @item4 => {
          quantity: 50,
          vendors: [@vendor2]
        },
        @item3 => {
          quantity: 35,
          vendors: [@vendor2, @vendor3]
        }
      }
      
      expect(@market.total_inventory).to eq(total_inventory_items)
    end
  end

  describe '#overstocked_items' do
    it 'returns array of items that are sold by more than one vendor and total quantity is greater than 50' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @vendor3.stock(@item3, 10)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      total_inventory_items = {
        @item1 => {
          quantity: 100,
          vendors: [@vendor1, @vendor3]
        },
        @item2 => {
          quantity: 7,
          vendors: [@vendor1]
        },
        @item4 => {
          quantity: 50,
          vendors: [@vendor2]
        },
        @item3 => {
          quantity: 35,
          vendors: [@vendor2, @vendor3]
        }
      }
      
      expect(@market.total_inventory).to eq(total_inventory_items)
      expect(@market.overstocked_items).to eq([@item1])
    end
  end

  describe '#sorted_item_list' do
    it 'returns an array of items sorted alphabetically by name' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @vendor3.stock(@item3, 10)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      total_inventory_items = {
        @item1 => {
          quantity: 100,
          vendors: [@vendor1, @vendor3]
        },
        @item2 => {
          quantity: 7,
          vendors: [@vendor1]
        },
        @item4 => {
          quantity: 50,
          vendors: [@vendor2]
        },
        @item3 => {
          quantity: 35,
          vendors: [@vendor2, @vendor3]
        }
      }
      
      expect(@market.total_inventory).to eq(total_inventory_items)
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe '#sell' do
    it ''
  end
end