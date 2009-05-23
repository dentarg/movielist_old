class FavoritesController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.favorite_movies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @favorites }
    end
  end

  # DELETE /favorite_movies/1
  # DELETE /favorite_movies/1.xml
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to(favorites_url) }
      format.xml  { head :ok }
    end
  end
end
