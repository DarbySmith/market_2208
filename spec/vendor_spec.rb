require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.descirbe Vendor do
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
end