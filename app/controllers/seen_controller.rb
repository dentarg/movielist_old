class SeenController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.seen

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # DELETE /seen_movies/1
  # DELETE /seen_movies/1.xml
  def destroy
    @seen   = Seen.find(params[:id])
    @movie  = @seen.movie
    @seen.destroy
    
    notice = "#{@movie.title} removed from your seen list."
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace_html 'message', notice
          page.hide dom_id(@movie) + '_row'
        end
      end
    end
  end
end
