class FavoriteMoviesController < ApplicationController
  # GET /favorite_movies
  # GET /favorite_movies.xml
  def index
    @favorite_movies = FavoriteMovie.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @favorite_movies }
    end
  end

  # GET /favorite_movies/1
  # GET /favorite_movies/1.xml
  def show
    @favorite_movie = FavoriteMovie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @favorite_movie }
    end
  end

  # GET /favorite_movies/new
  # GET /favorite_movies/new.xml
  def new
    @favorite_movie = FavoriteMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @favorite_movie }
    end
  end

  # GET /favorite_movies/1/edit
  def edit
    @favorite_movie = FavoriteMovie.find(params[:id])
  end

  # POST /favorite_movies
  # POST /favorite_movies.xml
  def create
    @favorite_movie = FavoriteMovie.new(params[:favorite_movie])

    respond_to do |format|
      if @favorite_movie.save
        flash[:notice] = 'FavoriteMovie was successfully created.'
        format.html { redirect_to(@favorite_movie) }
        format.xml  { render :xml => @favorite_movie, :status => :created, :location => @favorite_movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @favorite_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /favorite_movies/1
  # PUT /favorite_movies/1.xml
  def update
    @favorite_movie = FavoriteMovie.find(params[:id])

    respond_to do |format|
      if @favorite_movie.update_attributes(params[:favorite_movie])
        flash[:notice] = 'FavoriteMovie was successfully updated.'
        format.html { redirect_to(@favorite_movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @favorite_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_movies/1
  # DELETE /favorite_movies/1.xml
  def destroy
    @favorite_movie = FavoriteMovie.find(params[:id])
    @favorite_movie.destroy

    respond_to do |format|
      format.html { redirect_to(favorite_movies_url) }
      format.xml  { head :ok }
    end
  end
end
