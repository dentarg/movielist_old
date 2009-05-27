class MoviesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def seen
    @movie      = Movie.find(params[:id])
    @seen       = Seen.new
    @seen.movie = @movie
    @seen.user  = current_user

    respond_to do |format|
      if @seen.save
        notice = "#{@movie.title} added to your seen list."
        format.html do
          flash[:notice] = notice
          redirect_to(user_seen_index_path(current_user))
        end
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
            page.hide dom_id(@movie) + '_seen_link'
          end
        end
      else # FIXME
        format.html { render :text => "ERROR" }
      end
    end
  end
  
  def towatch
    @movie         = Movie.find(params[:id])
    @towatch       = Towatch.new
    @towatch.movie = @movie
    @towatch.user  = current_user

    respond_to do |format|
      if @towatch.save
        notice = "#{@movie.title} added to your to watch list."
        format.html do
          flash[:notice] = notice
          redirect_to(user_towatch_index_path(current_user))
        end
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
            page.hide dom_id(@movie) + '_towatch_link'
          end
        end
      else # FIXME
        format.html { render :text => "ERROR" }
      end
    end
  end  

  def favorite
    @movie          = Movie.find(params[:id])
    @favorite       = Favorite.new
    @favorite.movie = @movie
    @favorite.user  = current_user

    respond_to do |format|
      if @favorite.save
        notice = "#{@movie.title} added to your to favorites."
        format.html do
          flash[:notice] = notice
          redirect_to(user_favorites_path(current_user))
        end
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
            page.hide dom_id(@movie) + '_favorite_link'
          end
        end
      else # FIXME
        format.html { render :text => "ERROR" }
      end
    end
  end

  # GET /movies
  # GET /movies.xml
  def index
    @movies = Movie.find(:all, :order => 'title ASC' )

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
    @site_url = APP_CONFIG[:site_url]

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
    @movie.creator          = current_user
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
    if current_user == User.find(1)
      @movie = Movie.find(params[:id])
      @movie.destroy
      
      respond_to do |format|
        format.html { redirect_to(movies_url) }
        format.xml  { head :ok }
      end
    end
  end
end
