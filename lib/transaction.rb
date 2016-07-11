class Transaction
  attr_reader :product, :customer, :id

  @@transactions = []

  def initialize(customer, product)
  	@customer = customer
	@product = product
	@id = add_to_transactions
  end
  

  def self.all
    @@transactions
  end
  
  # keep in mind that transaction_id is greater from id by 1
  def self.find(transaction_id)
    @@transactions.find{|customer| customer.id === (transaction_id - 1)}
  end
  
  private
  
  def add_to_transactions
    if (@product.in_stock?)
	  @@transactions << self
	  @product.stock-=1
	  @@transactions.length
	else
      raise OutOfStockError, "'#{@product.title}' is out of stock."
    end
  end
end