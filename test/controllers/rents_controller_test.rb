require 'test_helper'

class RentsControllerTest < ActionController::TestCase
  setup do
    @rent = rents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rent" do
    assert_difference('Rent.count') do
      post :create, rent: { deleted: @rent.deleted, description: @rent.description, image: @rent.image, location: @rent.location, name: @rent.name, quantity: @rent.quantity, tag_list: @rent.tag_list, total_clicks: @rent.total_clicks, unavailable: @rent.unavailable, user_id: @rent.user_id }
    end

    assert_redirected_to rent_path(assigns(:rent))
  end

  test "should show rent" do
    get :show, id: @rent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rent
    assert_response :success
  end

  test "should update rent" do
    patch :update, id: @rent, rent: { deleted: @rent.deleted, description: @rent.description, image: @rent.image, location: @rent.location, name: @rent.name, quantity: @rent.quantity, tag_list: @rent.tag_list, total_clicks: @rent.total_clicks, unavailable: @rent.unavailable, user_id: @rent.user_id }
    assert_redirected_to rent_path(assigns(:rent))
  end

  test "should destroy rent" do
    assert_difference('Rent.count', -1) do
      delete :destroy, id: @rent
    end

    assert_redirected_to rents_path
  end
end
