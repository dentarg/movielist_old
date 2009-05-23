class TowatchController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.towatch_movies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @to_watch_movies }
    end
  end

  # DELETE /to_watch_movies/1
  # DELETE /to_watch_movies/1.xml
  def destroy
    @to_watch_movie = Towatch.find(params[:id])
    @to_watch_movie.destroy

    respond_to do |format|
      format.html { redirect_to(to_watch_movies_url) }
      format.xml  { head :ok }
    end
  end
end
