#uncomment the next line if you installed hpricot from the gem
require 'rubygems'
require 'hpricot'
require 'open-uri'

class IMDB
  TITLE_AND_YEAR_RE = /(.*) \((\d{4})\)/
  
  def initialize(url)
    @url = url
    @hp = Hpricot(open(@url))
  end
  
  def title
     @title = @hp.at("meta[@name='title']")['content'].match(TITLE_AND_YEAR_RE).to_a[1]
  end
    
  def year
    @year = @hp.at("meta[@name='title']")['content'].match(TITLE_AND_YEAR_RE).to_a[2]
  end
  
  def rating
      rating_text = (@hp/"span.rating-rating").inner_text
      if rating_text =~ /([\d\.]+)\/10/
        @rating = $1
      end
      @rating
  end
  
  def reset
    @rating = nil
    @extrainfo = nil
  end
end