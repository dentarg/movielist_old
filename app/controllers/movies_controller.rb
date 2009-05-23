class MoviesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def seen
    @movie            = Movie.find(params[:id])
    @seen_movie       = SeenMovie.new
    @seen_movie.movie = @movie
    @seen_movie.user  = current_user

    respond_to do |format|
      if @seen_movie.save
        flash[:notice] = "#{@movie.name} added to your seen list."
        format.html { redirect_to(user_seen_movies_path(current_user)) }
      else # FIXME
        format.html { render :action => "new" }
      end
    end
  end
  
  def to_watch
    @movie                = Movie.find(params[:id])
    @to_watch_movie       = ToWatchMovie.new
    @to_watch_movie.movie = @movie
    @to_watch_movie.user  = current_user

    respond_to do |format|
      if @to_watch_movie.save
        flash[:notice] = "#{@movie.name} added to your to watch list."
        format.html { redirect_to(user_to_watch_movies_path(current_user)) }
      else # FIXME
        format.html { render :action => "new" }
      end
    end
  end  

  def favorite
    @movie                = Movie.find(params[:id])
    @favorite_movie       = FavoriteMovie.new
    @favorite_movie.movie = @movie
    @favorite_movie.user  = current_user

    respond_to do |format|
      if @favorite_movie.save
        flash[:notice] = "#{@movie.name} added to your favorite list."
        format.html { redirect_to(user_favorite_movies_path(current_user)) }
      else # FIXME
        format.html { render :action => "new" }
      end
    end
  end

  # GET /movies
  # GET /movies.xml
  def index
    @movies = Movie.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])
    if @imdb_url = params[:movie][:imdb_url]
      imdb = IMDB.new(@imdb_url)
      @movie.title          = imdb.title
      @movie.year           = imdb.year
      @movie.imdb_id        = @imdb_url.match(Movie.imdb_url_regexp).to_a[3]
      @movie.imdb_rating    = imdb.rating
      @movie.imdb_update_at = Time.now
    end

    respond_to do |format|
      if @movie.save
        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(@movie) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        flash[:notice] = 'Movie was successfully updated.'
        format.html { redirect_to(@movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
end
