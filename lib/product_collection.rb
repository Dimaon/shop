class ProductCollection
  PRODUCT_TYPES = {
    film: {dir: 'films', class: FilmProduct},
    book: {dir: 'books', class: BookProduct},
    disk: {dir: 'disks', class: DiskProduct}
  }

  # Принимает на вход массив продуктов
  def initialize(products = [])
    @products = products
  end

  def self.from_dir(directory_path)
    products = []
    # Для каждого текстового файла из директории, например '/data/films/'
    # берем путь к файлу и передаем его в метод класса from_file, вызывая его
    # у объекта нужного класса.
    PRODUCT_TYPES.each do |type, hash|
      product_dir = hash[:dir]
      product_class = hash[:class]

      Dir[directory_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end
      self.new(products)
  end

  # Метод, чтобы достать все продукты коллекции
  def to_a
    @products
  end

  # Метод sort! меняет экземпляр класса ProductCollection (меняет порядок)
  # продуктов в коллекции, поэтому он назвал с восклицательным знаком. Этот
  # метод принимает на вход ассоциативный массив, в котором могут быть два
  # ключа: :by и :order. Например, чтобы отсортировать продукты по возрастанию
  # цены, можно вызвать этот метод так:
  #
  # collection.sort!(by: :price, order: :asc)
  def sort!(params)
    # Делает выбор по параметру by
    case params[:by]
    when :title
      @products.sort_by! { |product| product.to_s }
    when :price
      @products.sort_by! { |product| product.price }
    when :amount
      @products.sort_by! { |product| product.amount }
    end

    # Если запросили сортировку по возрастанию
    @products.reverse! if params[:order] == :asc

    # Возвращаем ссылку на экземпляр класса, чтобы у него по цепочке можно было вызвать
    # другие методы.
    self
  end
end
