class TowatchController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.towatch

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @to_watch_movies }
    end
  end

  # DELETE /to_watch_movies/1
  # DELETE /to_watch_movies/1.xml
  def destroy
    @towatch = Towatch.find(params[:id])
    @movie   = @towatch.movie
    @towatch.destroy
    
    notice = "#{@movie.title} removed from your to watch list."
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
