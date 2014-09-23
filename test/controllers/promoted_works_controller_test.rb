require 'test_helper'

class PromotedWorksControllerTest < ActionController::TestCase
  setup do
    @promoted_work = promoted_works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promoted_works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promoted_work" do
    assert_difference('PromotedWork.count') do
      post :create, promoted_work: { clicks: @promoted_work.clicks, image: @promoted_work.image, location: @promoted_work.location, name: @promoted_work.name, per_temporal_id: @promoted_work.per_temporal_id, price: @promoted_work.price, quantity: @promoted_work.quantity, set_clicks: @promoted_work.set_clicks, tag_list: @promoted_work.tag_list, temporal_id: @promoted_work.temporal_id, user_id: @promoted_work.user_id, work_id: @promoted_work.work_id }
    end

    assert_redirected_to promoted_work_path(assigns(:promoted_work))
  end

  test "should show promoted_work" do
    get :show, id: @promoted_work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promoted_work
    assert_response :success
  end

  test "should update promoted_work" do
    patch :update, id: @promoted_work, promoted_work: { clicks: @promoted_work.clicks, image: @promoted_work.image, location: @promoted_work.location, name: @promoted_work.name, per_temporal_id: @promoted_work.per_temporal_id, price: @promoted_work.price, quantity: @promoted_work.quantity, set_clicks: @promoted_work.set_clicks, tag_list: @promoted_work.tag_list, temporal_id: @promoted_work.temporal_id, user_id: @promoted_work.user_id, work_id: @promoted_work.work_id }
    assert_redirected_to promoted_work_path(assigns(:promoted_work))
  end

  test "should destroy promoted_work" do
    assert_difference('PromotedWork.count', -1) do
      delete :destroy, id: @promoted_work
    end

    assert_redirected_to promoted_works_path
  end
end
