class SeenMoviesController < ApplicationController
  # GET /seen_movies
  # GET /seen_movies.xml
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.seen_movies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seen_movies }
    end
  end

  # GET /seen_movies/1
  # GET /seen_movies/1.xml
  def show
    @seen_movie = SeenMovie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seen_movie }
    end
  end

  # GET /seen_movies/new
  # GET /seen_movies/new.xml
  def new
    @seen_movie = SeenMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seen_movie }
    end
  end

  # GET /seen_movies/1/edit
  def edit
    @seen_movie = SeenMovie.find(params[:id])
  end

  # POST /seen_movies
  # POST /seen_movies.xml
  def create
    @seen_movie = SeenMovie.new(params[:seen_movie])

    respond_to do |format|
      if @seen_movie.save
        flash[:notice] = 'SeenMovie was successfully created.'
        format.html { redirect_to(@seen_movie) }
        format.xml  { render :xml => @seen_movie, :status => :created, :location => @seen_movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seen_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seen_movies/1
  # PUT /seen_movies/1.xml
  def update
    @seen_movie = SeenMovie.find(params[:id])

    respond_to do |format|
      if @seen_movie.update_attributes(params[:seen_movie])
        flash[:notice] = 'SeenMovie was successfully updated.'
        format.html { redirect_to(@seen_movie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seen_movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seen_movies/1
  # DELETE /seen_movies/1.xml
  def destroy
    @seen_movie = SeenMovie.find(params[:id])
    @seen_movie.destroy

    respond_to do |format|
      format.html { redirect_to(seen_movies_url) }
      format.xml  { head :ok }
    end
  end
end
