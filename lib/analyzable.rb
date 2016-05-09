module Analyzable
  # Your code goes here!
  def average_price(list_items)
    sum = 0.0
    list_items.each do |item|
      sum += item.price.to_f
    end
    (sum/list_items.length).round(2)
  end

end
