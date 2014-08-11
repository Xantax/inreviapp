require 'test_helper'

class PromotedOffersControllerTest < ActionController::TestCase
  setup do
    @promoted_offer = promoted_offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promoted_offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promoted_offer" do
    assert_difference('PromotedOffer.count') do
      post :create, promoted_offer: { offer_id: @promoted_offer.offer_id, user_id: @promoted_offer.user_id }
    end

    assert_redirected_to promoted_offer_path(assigns(:promoted_offer))
  end

  test "should show promoted_offer" do
    get :show, id: @promoted_offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promoted_offer
    assert_response :success
  end

  test "should update promoted_offer" do
    patch :update, id: @promoted_offer, promoted_offer: { offer_id: @promoted_offer.offer_id, user_id: @promoted_offer.user_id }
    assert_redirected_to promoted_offer_path(assigns(:promoted_offer))
  end

  test "should destroy promoted_offer" do
    assert_difference('PromotedOffer.count', -1) do
      delete :destroy, id: @promoted_offer
    end

    assert_redirected_to promoted_offers_path
  end
end
