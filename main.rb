require_relative("lib/product")
require_relative("lib/film_product")
require_relative("lib/book_product")
require_relative("lib/disk_product")
require_relative("lib/product_collection")
require_relative("lib/cart")

collection = ProductCollection.from_dir(__dir__ + '/data')
cart = Cart.new

# Возвращает выбранный продукт
def choosed_product(user_choice, collection)
  collection.to_a[user_choice]
end

loop do
  puts "\n\r Что вы хотите купить: \n\r "

  # Вывести список всех продуктов c порядковым номером
  collection.to_a.each_with_index do |product, index|
    puts "#{index + 1} - #{product} (Осталось: #{cart.current_product_amount(product)})"
  end
  puts "0 - выход"

  user_choice = STDIN.gets.to_i - 1

  while user_choice > collection.to_a.size || user_choice < -1 do
    puts "Введите корректное число"
    user_choice = STDIN.gets.to_i - 1
  end
  break if user_choice == -1
  # Добавить товар в корзину
  product = choosed_product(user_choice, collection)
  if cart.current_product_amount(product) > 0
    cart.add_product(product)
    print "Вы выбрали: "
    puts "#{cart.current_product}  Осталось: #{cart.current_product_amount}"
    puts "Всего товаров на сумму: #{cart.cost_cart} руб."
    # sleep(0.5)
  else
    puts "Товар закончился"
  end
end

puts "Вы купили:"
cart.collection.each do |product, amount|
  puts "#{product}  #{amount} шт."
end

puts "Всего товаров на сумму: #{cart.cost_cart} руб."