class FilmProduct < Product
  attr_accessor :year, :director

  def initialize(params)
    super
    @year = params[:year]
    @director = params[:director]
  end

  def to_s
    "Фильм '#{@title}', #{@year}, реж. #{@director}, #{@price} руб."
  end

  def update(params)
    super
    @year = params[:year] if params[:year]
    @director = params[:director] if params[:director]
  end

  # Метод класса создающий свой экзмепляр из файла
  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map{|i| i.chomp}
    params = {
      title: lines[0],
      director: lines[2],
      year: lines[3].to_i,
      price: lines[3].to_i,
      amount: lines[4].to_i
    }
    self.new(params)
  end
end
