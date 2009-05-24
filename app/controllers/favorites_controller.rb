class FavoritesController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.favorites

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @favorites }
    end
  end

  # DELETE /favorite_movies/1
  # DELETE /favorite_movies/1.xml
  def destroy
    @favorite = Favorite.find(params[:id])
    @movie    = @favorite.movie
    @favorite.destroy
    
    notice = "#{@movie.title} removed from your favorite list."
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
