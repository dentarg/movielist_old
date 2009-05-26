class MovieNightsController < ApplicationController
  def index
    @movie_nights = MovieNight.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movie_nights }
    end
  end

  def search
    @movie_night = MovieNight.find(params[:id])
    body    = params[:query][:body]
    results = User.search(body)
    #results = results - @movie_night.participants

    respond_to do |format|
      format.js do
        render :update do |page|
          if !results.empty?
            page.replace_html 'prospects', :partial => "prospect", 
              :collection => results, :as => :prospect, :locals => { :movie_night => @movie_night }
          elsif body.empty? # No search
            render :nothing => true
          elsif results.empty?
            render :nothing => true
          end
        end
      end
    end
  end

  def show
    @movie_night    = MovieNight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie_night }
    end
  end

  def register
    @movie_night = MovieNight.find(params[:id])
    @participant = User.find(params[:user_id])
    if @movie_night.register(@participant)
      notice = "#{@participant} added!"
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
            page.insert_html :top, 'participants', :partial => 'participant', 
              :locals => { :movie_night => @movie_night, :participant => @participant }
            page.replace 'movies_towatch', :partial => 'towatch', 
              :locals => { :movies => @movie_night.movies_towatch }
            page.replace 'movies_seen', :partial => 'seen', 
              :locals => { :movie_night => @movie_night }
          end
        end
        format.html do
          flash[:notice] = notice
          redirect_to(@movie_night)
        end
      end
    else
      notice = "Failed to add participant"
      respond_to do |format|
        format.js do
          render :update do |page|
            # TODO: Style this message with red background
            page.replace_html 'message', notice
          end
        end
      end
    end
  end

  def unregister
    @movie_night = MovieNight.find(params[:id])
    @participant = User.find(params[:user_id])
    if @movie_night.unregister(@participant)
      notice = "#{@participant} removed!"
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
            page.remove dom_id(@participant)
            page.replace 'movies_towatch', :partial => 'towatch',
              :locals => { :movies => @movie_night.movies_towatch }
            page.replace 'movies_seen', :partial => 'seen', 
              :locals => { :movie_night => @movie_night }
          end
        end
        format.html do
          flash[:notice] = notice
          redirect_to(@movie_night)
        end
      end
    else
      notice = "Failed to remove participant"
      respond_to do |format|
        format.js do
          render :update do |page|
            page.replace_html 'message', notice
          end
        end
      end
    end
  end

  def new
    @movie_night = MovieNight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie_night }
    end
  end

  def create
    @movie_night = MovieNight.new(params[:movie_night])
    
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

  def destroy
    @movie_night = MovieNight.find(params[:id])
    @movie_night.destroy

    respond_to do |format|
      format.html { redirect_to(movie_nights_url) }
      format.xml  { head :ok }
    end
  end
end
