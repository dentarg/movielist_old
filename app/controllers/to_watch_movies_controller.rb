class ToWatchMoviesController < ApplicationController
  # GET /to_watch_movies
  # GET /to_watch_movies.xml
  def index
    @to_watch_movies = ToWatchMovie.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @to_watch_movies }
    end
  end

  # GET /to_watch_movies/1
  # GET /to_watch_movies/1.xml
  def show
    @to_watch_movie = ToWatchMovie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @to_watch_movie }
    end
  end

  # GET /to_watch_movies/new
  # GET /to_watch_movies/new.xml
  def new
    @to_watch_movie = ToWatchMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @to_watch_movie }
    end
  end

  # GET /to_watch_movies/1/edit
  def edit
    @to_watch_movie = ToWatchMovie.find(params[:id])
  end

  # POST /to_watch_movies
  # POST /to_watch_movies.xml
  def create
    @to_watch_movie = ToWatchMovie.new(params[:to_watch_movie])

    respond_to do |format|
      if @to_watch_movie.save
        flash[:notice] = 'ToWatchMovie was successfully created.'
        format.html { redirect_to(@to_watch_movie) }
        format.xml  { render :xml => @to_watch_movie, :status => :created, :location => @to_watch_movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @to_watch_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /to_watch_movies/1
  # PUT /to_watch_movies/1.xml
  def update
    @to_watch_movie = ToWatchMovie.find(params[:id])

    respond_to do |format|
      if @to_watch_movie.update_attributes(params[:to_watch_movie])
        flash[:notice] = 'ToWatchMovie was successfully updated.'
        format.html { redirect_to(@to_watch_movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @to_watch_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /to_watch_movies/1
  # DELETE /to_watch_movies/1.xml
  def destroy
    @to_watch_movie = ToWatchMovie.find(params[:id])
    @to_watch_movie.destroy

    respond_to do |format|
      format.html { redirect_to(to_watch_movies_url) }
      format.xml  { head :ok }
    end
  end
end
