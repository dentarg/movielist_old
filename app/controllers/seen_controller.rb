class SeenController < ApplicationController
  def index
    @user   = User.find(params[:user_id])
    @movies = @user.seen_movies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # DELETE /seen_movies/1
  # DELETE /seen_movies/1.xml
  def destroy
    @seen_movie = Seen.find(params[:id])
    @seen_movie.destroy

    respond_to do |format|
      format.html { redirect_to(seen_movies_url) }
      format.xml  { head :ok }
    end
  end
end
