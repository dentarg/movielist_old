class MovieNightsController < ApplicationController
  # GET /movie_nights
  # GET /movie_nights.xml
  def index
    @movie_nights = MovieNight.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movie_nights }
    end
  end

  # GET /movie_nights/1
  # GET /movie_nights/1.xml
  def show
    @movie_night    = MovieNight.find(params[:id])
    @users          = @movie_night.users
    @movies_towatch = @movie_night.movies_towatch
    @movies_seen    = @movie_night.movies_seen

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie_night }
    end
  end

  # GET /movie_nights/new
  # GET /movie_nights/new.xml
  def new
    @movie_night = MovieNight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie_night }
    end
  end

  # GET /movie_nights/1/edit
  def edit
    @movie_night = MovieNight.find(params[:id])
  end

  # POST /movie_nights
  # POST /movie_nights.xml
  def create
    @movie_night = MovieNight.new(params[:movie_night])
    
    # This isn't good code
    @movie_night.user_ids = "[2, 3]"
    users = eval(@movie_night.user_ids).map { |u| User.find(u) }
    @movie_night.towatch_movie_ids = eval(users.map(&:towatch_movie_ids).map(&:to_json).join("&")).to_json
    @movie_night.seen_movie_ids    = eval(users.map(&:seen_movie_ids).map(&:to_json).join("|")).to_json

    respond_to do |format|
      if @movie_night.save
        flash[:notice] = 'MovieNight was successfully created.'
        format.html { redirect_to(@movie_night) }
        format.xml  { render :xml => @movie_night, :status => :created, :location => @movie_night }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie_night.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movie_nights/1
  # PUT /movie_nights/1.xml
  def update
    @movie_night = MovieNight.find(params[:id])

    respond_to do |format|
      if @movie_night.update_attributes(params[:movie_night])
        flash[:notice] = 'MovieNight was successfully updated.'
        format.html { redirect_to(@movie_night) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie_night.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_nights/1
  # DELETE /movie_nights/1.xml
  def destroy
    @movie_night = MovieNight.find(params[:id])
    @movie_night.destroy

    respond_to do |format|
      format.html { redirect_to(movie_nights_url) }
      format.xml  { head :ok }
    end
  end
end
