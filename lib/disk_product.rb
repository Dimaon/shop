class DiskProduct < Product
    attr_accessor :year, :artist

    def initialize(params)
      super
      @year = params[:year]
      @artist = params[:artist]
    end

    def to_s
      "Альбом '#{@title} - #{@artist}', #{@year}, , #{@price} руб. (осталось: #{@amount})"
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
          title:  lines[0],
          artist: lines[1],
          genre:  lines[1],
          year:   lines[3].to_i,
          price:  lines[4].to_i,
          amount: lines[5].to_i
      }
      self.new(params)
    end
end