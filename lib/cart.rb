class Cart
  attr_reader :collection
  def initialize
    @collection = {}
    @amount = 1
  end

  def add_product(product)
    @product = product
    amount = 1
    if @collection.has_key?(@product)
      @collection[@product] += 1
    else
      @collection[@product] = 1
    end
  end

  def current_product(product = @product)
    product
  end

  def current_product_amount(product = @product)
    return product.amount unless @collection[product]
    product.amount - @collection[product]
  end

  def cost_cart
    total_price = 0
    @collection.each_pair do |product, amount|
      total_price += product.price * amount
    end
    total_price
  end
end