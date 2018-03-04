require_relative("lib/product")
require_relative("lib/film_product")
require_relative("lib/book_product")
require_relative("lib/disk_product")
require_relative("lib/product_collection")

COLLECTION = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')

# Вынести в класс Корзина (Начало)
# Сюда складываем обьекты-продукты для покупки
collection_to_buy = []

# Создаем массив из обьектов-продуктов, которые выбрал пользователь
def add_to_collection(user_choice, collection_to_buy, collection)
  collection_to_buy << updated_amount_product(user_choice, collection)
end

# Показывает выбранный продукт
def choosed_product(user_choice, collection)
  puts collection.to_a[user_choice]
end

# Вычитаем кол-во товара и возвращаем измененный обьект
def updated_amount_product(user_choice, collection)
  product = collection.to_a[user_choice]
  product.amount -= 1 if product.amount > 0
  product
end

# Рассчет стоимости корзины выбранных товаров
def calc_total_cost(collection_to_buy, original_collection)
  total_cost = 0
  collection_to_buy.uniq.to_a.each do |product|
    original_collection.to_a.each do |original_product|
      if original_product.title == product.title
        amount = original_product.amount - product.amount
        product.amount_to_buy = amount
        cost = amount * product.price
        total_cost += cost
      end
    end
  end
  return total_cost
end
# Вынести в класс Корзина (Конец)

# Основное тело программы.
loop do
  puts "\n\r Что вы хотите купить: \n\r "

  # Вывести список всех продуктов c порядковым номером
  collection.to_a.each_with_index do |product, index|
    puts "#{index + 1} - #{product}"
  end
  puts "0 - выход"

  user_choice = STDIN.gets.to_i - 1
  puts collection.to_a.size
  while user_choice > collection.to_a.size || user_choice < -1 do
    puts "Введите корректное число"
    user_choice = STDIN.gets.to_i - 1
  end
  break if user_choice == -1

  add_to_collection(user_choice, collection_to_buy, collection)
  print "Вы выбрали: "
  puts choosed_product(user_choice, collection)
  print "На сумму: #{calc_total_cost(collection_to_buy, COLLECTION)}"
  sleep(0.5)
end

# Выводим купленные продукты с итоговой стоиомстью и остатками
def cost_collection(collection_to_buy, original_collection)
  collection_to_buy.uniq.to_a.each do |product|
    puts "#{product} - #{product.amount_to_buy} шт."
  end
  total_cost = calc_total_cost(collection_to_buy, original_collection)
  puts "На общую сумму #{total_cost} руб."
end

puts "Вы купили: "
cost_collection(collection_to_buy, COLLECTION)







