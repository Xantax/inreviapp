require 'test_helper'

class PromotedRentsControllerTest < ActionController::TestCase
  setup do
    @promoted_rent = promoted_rents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promoted_rents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promoted_rent" do
    assert_difference('PromotedRent.count') do
      post :create, promoted_rent: { clicks: @promoted_rent.clicks, image: @promoted_rent.image, location: @promoted_rent.location, name: @promoted_rent.name, per_temporal_id: @promoted_rent.per_temporal_id, price: @promoted_rent.price, quantity: @promoted_rent.quantity, rent_id: @promoted_rent.rent_id, sell: @promoted_rent.sell, set_clicks: @promoted_rent.set_clicks, tag_list: @promoted_rent.tag_list, temporal_id: @promoted_rent.temporal_id, unavailable: @promoted_rent.unavailable, user_id: @promoted_rent.user_id }
    end

    assert_redirected_to promoted_rent_path(assigns(:promoted_rent))
  end

  test "should show promoted_rent" do
    get :show, id: @promoted_rent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promoted_rent
    assert_response :success
  end

  test "should update promoted_rent" do
    patch :update, id: @promoted_rent, promoted_rent: { clicks: @promoted_rent.clicks, image: @promoted_rent.image, location: @promoted_rent.location, name: @promoted_rent.name, per_temporal_id: @promoted_rent.per_temporal_id, price: @promoted_rent.price, quantity: @promoted_rent.quantity, rent_id: @promoted_rent.rent_id, sell: @promoted_rent.sell, set_clicks: @promoted_rent.set_clicks, tag_list: @promoted_rent.tag_list, temporal_id: @promoted_rent.temporal_id, unavailable: @promoted_rent.unavailable, user_id: @promoted_rent.user_id }
    assert_redirected_to promoted_rent_path(assigns(:promoted_rent))
  end

  test "should destroy promoted_rent" do
    assert_difference('PromotedRent.count', -1) do
      delete :destroy, id: @promoted_rent
    end

    assert_redirected_to promoted_rents_path
  end
end
