class BookProduct < Product
  attr_accessor :genre, :author
  def initialize(params)
    super
    @genre = params[:genre]
    @author = params[:author]
  end

  def to_s
    "Книга '#{@title}', автор - #{@author}, #{@price} руб. (осталось: #{@amount})"
  end

  def update(params)
    @genre = params[:genre] if params[:genre]
    @author = params[:author] if params[:author]
  end

  # Метод класса создающий свой экзмепляр из файла
  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map{|i| i.chomp}
    params = {
        title: lines[0],
        genre: lines[1],
        author: lines[2],
        price: lines[3].to_i,
        amount: lines[4].to_i
    }
    self.new(params)
  end
end