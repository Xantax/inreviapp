require 'test_helper'

class WorksControllerTest < ActionController::TestCase
  setup do
    @work = works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post :create, work: { deleted: @work.deleted, description: @work.description, image: @work.image, location: @work.location, name: @work.name, per_temporal_id: @work.per_temporal_id, price: @work.price, quantity: @work.quantity, tag_list: @work.tag_list, temporal_id: @work.temporal_id, total_clicks: @work.total_clicks, user_id: @work.user_id }
    end

    assert_redirected_to work_path(assigns(:work))
  end

  test "should show work" do
    get :show, id: @work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work
    assert_response :success
  end

  test "should update work" do
    patch :update, id: @work, work: { deleted: @work.deleted, description: @work.description, image: @work.image, location: @work.location, name: @work.name, per_temporal_id: @work.per_temporal_id, price: @work.price, quantity: @work.quantity, tag_list: @work.tag_list, temporal_id: @work.temporal_id, total_clicks: @work.total_clicks, user_id: @work.user_id }
    assert_redirected_to work_path(assigns(:work))
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete :destroy, id: @work
    end

    assert_redirected_to works_path
  end
end
