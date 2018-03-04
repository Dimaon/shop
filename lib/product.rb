class Product
  attr_accessor :price, :amount, :title, :amount_to_buy

  def initialize(params)
    @price = params[:price]
    @amount = params[:amount]
    @title = params[:title]
  end

  def to_s
    "#{@price} руб. (осталось #{@amount})"
  end

  def update(params)
    @price = params[:price] if params[:price]
    @amount = params[:amount] if params[:amount]
    @title = params[:title] if params[:title]
  end

  def self.from_file(file_path)
    raise NotImplementedError
  end
end