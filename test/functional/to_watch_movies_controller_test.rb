require 'test_helper'

class ToWatchMoviesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:to_watch_movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create to_watch_movie" do
    assert_difference('ToWatchMovie.count') do
      post :create, :to_watch_movie => { }
    end

    assert_redirected_to to_watch_movie_path(assigns(:to_watch_movie))
  end

  test "should show to_watch_movie" do
    get :show, :id => to_watch_movies(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => to_watch_movies(:one).id
    assert_response :success
  end

  test "should update to_watch_movie" do
    put :update, :id => to_watch_movies(:one).id, :to_watch_movie => { }
    assert_redirected_to to_watch_movie_path(assigns(:to_watch_movie))
  end

  test "should destroy to_watch_movie" do
    assert_difference('ToWatchMovie.count', -1) do
      delete :destroy, :id => to_watch_movies(:one).id
    end

    assert_redirected_to to_watch_movies_path
  end
end
