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
    @@transactions.find{|transaction| transaction.id === (transaction_id - 1)}
  end
  
  def self.find_by_customer_name(customer_name)
    @@transactions.select{|transaction| transaction.customer.name === customer_name}
  end
  
  def self.find_by_customer(customer)
    @@transactions.select{|transaction| transaction.customer === customer}
  end
  
  def self.find_by_product(product)
    @@transactions.select{|transaction| transaction.product === product}
  end
  
  def self.find_by_product_title(product_title)
    @@transactions.select{|transaction| transaction.product.title === product_title}
  end
  
  
  def to_s
    # \r\n is for Windows only, \n for Unix
	# can I somehow make this code multiplatform?
    "\r\n***\r\nTransaction id: #{@id}\r\n#{@product}\r\n#{@customer}\r\n***"
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