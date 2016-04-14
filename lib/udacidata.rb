require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  $datafile_path = File.dirname(__FILE__) + "/../data/data.csv"
  def self.create(attributes = {})
    data_entry = self.new(attributes)
    data_entry.save
    data_entry
  end

  def save
    CSV.open($datafile_path,'ab') do |csv|
      csv << [self.id, self.brand, self.name, self.price]
    end
  end

  def self.all
    list_products = []
    CSV.read($datafile_path).drop(1).each do |row|
      list_products << self.new(id: row[0], brand: row[1], name: row[2], price: row[3])
    end
    list_products
  end

  def self.first(n=1)
    list_products = self.all
    if(n > 1 && n < list_products.length)
      list_products[0..(n-1)]
    else
      list_products[n-1]
    end
  end

  def self.last(n=1)
    list_products = self.all
    if(n > 1 && n < list_products.length)
      list_products[n..-1]
    else
      list_products[-1]
    end
  end
end
