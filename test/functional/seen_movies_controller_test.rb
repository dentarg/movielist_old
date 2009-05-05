require 'test_helper'

class SeenMoviesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seen_movies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seen_movie" do
    assert_difference('SeenMovie.count') do
      post :create, :seen_movie => { }
    end

    assert_redirected_to seen_movie_path(assigns(:seen_movie))
  end

  test "should show seen_movie" do
    get :show, :id => seen_movies(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seen_movies(:one).id
    assert_response :success
  end

  test "should update seen_movie" do
    put :update, :id => seen_movies(:one).id, :seen_movie => { }
    assert_redirected_to seen_movie_path(assigns(:seen_movie))
  end

  test "should destroy seen_movie" do
    assert_difference('SeenMovie.count', -1) do
      delete :destroy, :id => seen_movies(:one).id
    end

    assert_redirected_to seen_movies_path
  end
end
