require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before (:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@vendor).to be_instance_of(Vendor)
    end

    it 'has a name' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
    end

    it 'has no inventory to start' do
      expect(@vendor.inventory).to eq({})
    end
  end

  describe '#stock' do
    it 'can add given item and amount to the inventory' do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({@item1 => 30})

      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to eq({@item1 => 30, @item2 => 12})
    end
  end
  
  describe '#check_stock' do
    it 'can check the stock of a given item' do
      @vendor.stock(@item1, 30)
      expect(@vendor.check_stock(@item1)).to eq(30)
      
      @vendor.stock(@item1, 25)
      expect(@vendor.check_stock(@item1)).to eq(55)
    end
  end
end