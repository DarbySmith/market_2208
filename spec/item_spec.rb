require 'rspec'
require './lib/item'

RSpec.descirbe Item do
  before (:each) do
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  descirbe '#initialize' do
    it 'exists' do
      expect(@item1).to be_instance_of(Item)
    end

    it 'has a name' do
      expect(@item1.name).to eq('Peach')
    end

    it 'has a price' do
      expect(@item.price).to eq(0.75)
    end
  end
end
