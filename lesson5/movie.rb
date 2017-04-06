class Movie
  attr_reader *TITRES, :manthf
 
  def initialize(owner, film)
    @link = film[:link]
    @name = film[:name]
    @year = film[:year]
    @country = film[:country].split(',')
    @date = film[:date]
    @genre = film[:genre].split(',')
    @duratation = film[:duratation]
    @rating = film[:rating]
    @director = film[:director].split(' ').reverse.join(' ') 
    @actors = film[:actors].split(',')
    @collection = owner 
  end

  def has_genre? genre 
     raise  "Извините! Вы ошиблись, такого жанра нет" unless @collection.genries.include?(genre)
     @genre.include?(genre)
  end

  def to_s 
   print "\t #{@name}: #{@director} ( #{@year}, #{@genre.join('/')} - #{@duratation}). \n\b"
  end
  
  def month
    # Date.parse(self.date).strftime("%B") if self.date.length == 10
    self.date[5..6] if self.date.length == 10
  end
  def match_filter?(**option)
      s = ""
      option.each{|k, v| s += ( " && " + ( v ===  ((self.send(k).class==Array) ? self.send(k).join(',')  : self.send(k)) ).to_s)}
      return s
  end
end
