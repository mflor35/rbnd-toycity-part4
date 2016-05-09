module Analyzable
  # Your code goes here!
  def average_price(list_items)
    sum = list_items.inject(0){ |total, item| total + item.price.to_f }
    (sum/list_items.length).round(2)
  end

  def print_report(list_products)
    report = ""
    header = "|%2s|%10s|%15s|%10s|\n"%["ID","Brand","Name","Price"]
    dashes = '-'*(header.length-1)
    report += dashes + "\n"
    report += header
    report += dashes + "\n"
    list_products.each do |product|
      report += "|%2s|%10s|%15s|%10s|\n"%["#{product.id}","#{product.brand}","#{product.name}","#{product.price}"]
    end
    report += dashes + "\n"
    report
  end

  def count_by_brand(list_products)
    result = {}
    list_products.each do |item|
      if !result.keys.include?(item.brand)
        result[item.brand] = 1
      else
        result[item.brand] += 1
      end
    end
    result
  end

  def count_by_name(list_products)
    result = {}
    list_products.each do |item|
      if !result.keys.include?(item.name)
        result[item.name] = 1
      else
        result[item.name] += 1
      end
    end
    result
  end

end
