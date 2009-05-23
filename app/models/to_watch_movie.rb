class ToWatchMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  
  delegate  :title,       :to => :movie
  delegate  :title_sv,    :to => :movie
  delegate  :year,        :to => :movie
  delegate  :imdb_id,     :to => :movie
  delegate  :imdb_url,    :to => :movie
  delegate  :imdb_rating, :to => :movie
  delegate  :dn_grade,    :to => :movie
  delegate  :dn_url,      :to => :movie
  
  delegate  :seen?,     :to => :movie
  delegate  :favorite?, :to => :movie
  delegate  :to_watch?, :to => :movie
end
