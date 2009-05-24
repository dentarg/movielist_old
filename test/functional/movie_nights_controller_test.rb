require 'test_helper'

class MovieNightsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:movie_nights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create movie_night" do
    assert_difference('MovieNight.count') do
      post :create, :movie_night => { }
    end

    assert_redirected_to movie_night_path(assigns(:movie_night))
  end

  test "should show movie_night" do
    get :show, :id => movie_nights(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => movie_nights(:one).id
    assert_response :success
  end

  test "should update movie_night" do
    put :update, :id => movie_nights(:one).id, :movie_night => { }
    assert_redirected_to movie_night_path(assigns(:movie_night))
  end

  test "should destroy movie_night" do
    assert_difference('MovieNight.count', -1) do
      delete :destroy, :id => movie_nights(:one).id
    end

    assert_redirected_to movie_nights_path
  end
end
