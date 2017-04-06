class MovieCollection 
  
  attr_reader :allfilms, :genries
  
  def initialize filmfile
    unless File.exist?(filmfile)  
      abort " Такого файла не существует"
    end
    @allfilms = CSV.read(filmfile, col_sep: '|', headers: TITRES ).map{ |f| Movie.new(self, f.to_h) }
    @genries = genres
  end

  def all
     @allfilms
  end

  def sortby (name)
    @allfilms.sort_by(&name) 
  end

  def actors
    @allfilms.map {|f|  f.actors }
  end

  def filtr(**options)
    year, genre =  options.keys
    years_list = options[year]
    genres_list = options[genre]
    @allfilms.select{ |f| years_list === f.send(year).to_i }.select{ |f|  /(#{genres_list})/ === (f.send(genre)).join(',') } 
  end

  def stats(field)
    @allfilms.flat_map(&field).compact.sort.inject(Hash.new(0)){|h, e| h[e]+=1; h }  
  end

  def print_stats k, v
    puts "\t#{k.ljust(15)} #{v}"
  end

  def genres
    @genries = all.flat_map(&:genre).uniq.sort
  end

  def filter(option) 
    @allfilms.select{ |f|  eval("true " +  f.match_filter?(option))} 
  end
end
