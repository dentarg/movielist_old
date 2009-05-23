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
      rating_text = (@hp/"div.meta/b").inner_text
      if rating_text =~ /([\d\.]+)\/10/
        @rating = $1
      end
      @rating
  end
  
  def extrainfo
   if @extrainfo == nil #don't do it twice
      @extrainfo = {} #init our hash
      (@hp/"div.info").each do |inf| #go through each info div
        title = inf/"h5" #the type of infobox is stored in h5
        if title.any? #if we found one , we got data
          body = inf.inner_text
          body = body.gsub(/\n/,'') #remove newlines
          if body =~ /\:(.+)/ #extract body from our text
            body = $1
          end
          @extrainfo[title.inner_text.gsub(/[:\s]/,'').downcase] = body #store the body
        end
      end
    end
      @extrainfo
  end
  
  def reset
    @rating = nil
    @extrainfo = nil
  end
end