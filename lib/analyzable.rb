module Analyzable
  # Your code goes here!
  def average_price(list_items)
    sum = 0.0
    list_items.each do |item|
      sum += item.price.to_f
    end
    (sum/list_items.length).round(2)
  end

  def print_report(list_products)
    " "
  end

  def count_by_brand(list_products)
    {list_products[0].brand => list_products.length}
  end

  def count_by_name(list_products)
    {list_products[0].name => list_products.length}
  end

end
