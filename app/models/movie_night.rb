class MovieNight < ActiveRecord::Base

  has_and_belongs_to_many :participants, :class_name => 'User', :uniq => true

  def to_s
    self.id.to_s
  end

  def register(user)
    self.participants << user unless self.participants.include?(user)
  end
  
  def unregister(user)
    self.participants.delete(user) if self.participants.include?(user)
  end  
  
  # A bit hacky - but hey, it works...
  def movies_towatch
    unless self.participants.empty?
      Movie.find(eval(self.participants.map(&:towatch_movie_ids).map(&:to_json).join("&")))
    else
      []
    end
  end
  
  def movies_seen
    unless self.participants.empty?
      Movie.find(eval(self.participants.map(&:seen_movie_ids).map(&:to_json).join("|")))
    else
      []
    end
  end  
end
