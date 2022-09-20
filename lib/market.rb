class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name 
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory[item] != 0
    end
  end

  def total_inventory
    inventory_available = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        if inventory_available[item] == nil
          inventory_available[item] = {
            quantity: amount, 
            vendors: vendors_that_sell(item)
            }
        else
          inventory_available[item][:quantity] += amount
        end
      end
    end
    inventory_available
  end

  def overstocked_items
    total_inventory.select do |item, details|
      details[:quantity] > 50 && details[:vendors].count >= 2
    end.keys
  end

  def sorted_item_list
    total_inventory.keys.map {|item| item.name}.sort
  end
end