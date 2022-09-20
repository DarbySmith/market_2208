require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before (:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
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
    end
  end
  
  # describe '#check_stock' do

  # end
end