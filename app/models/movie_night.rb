class MovieNight < ActiveRecord::Base
  def users
    eval(self.user_ids).map { |u| User.find(u) }
  end
  
  def movies_towatch
    Movie.find(eval(self.towatch_movie_ids))
  end
  
#  @movie_night.towatch_movie_ids = eval(users.map(&:towatch_movie_ids).map(&:to_json).join("&")).to_json
#  @movie_night.seen_movie_ids    = eval(users.map(&:seen_movie_ids).map(&:to_json).join("|")).to_json  
  
  def movies_seen
    unless self.seen_movie_ids.nil?
      Movie.find(eval(self.seen_movie_ids))
    else
      []
    end
  end
  
  def to_s
    self.id.to_s
  end
end
