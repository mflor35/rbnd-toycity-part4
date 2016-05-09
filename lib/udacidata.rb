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

  create_finder_methods('id','brand','name','price')

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

  def self.find(id)
    raise ProductNoFoundError, "No Product with #{id}" +  " found." unless self.all.length > id
    self.all.find{|product| product.id == id}

  end

  def self.destroy(id)
    product = self.find(id)
    self.remove_from_db(id)
    product
  end

  def self.where(args={})
    result = []
    args.each do |key,value|
      self.all.each do |product|
        if product.send(key) == value
          result << product
        end
      end
    end
    result
  end

  def update(args={})
    data = Product.all
    args.each do |key, value|
      self.send("#{key}=",value) if self.respond_to?(key)
    end

    CSV.open($datafile_path, 'wb') do |csv|
      csv << ["id", "brand", "product", "price"]
      data.each do |item|
        item = self if item.id == self.id
        csv << [item.id, item.brand, item.name, item.price]
      end
    end
    self
  end

  # Helper methods
  def save
    CSV.open($datafile_path,'ab') do |csv|
      csv << [self.id, self.brand, self.name, self.price]
    end
  end

  def self.remove_from_db(id)
    db = CSV.table($datafile_path)
    db.delete_if do |row|
      row[:id] == id
    end

    File.open($datafile_path,'w') do |file|
      file.write(db.to_csv)
    end
  end

end
