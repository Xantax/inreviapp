require 'test_helper'

class PromotedServicesControllerTest < ActionController::TestCase
  setup do
    @promoted_service = promoted_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promoted_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promoted_service" do
    assert_difference('PromotedService.count') do
      post :create, promoted_service: { image: @promoted_service.image, location: @promoted_service.location, name: @promoted_service.name, price: @promoted_service.price, service_id: @promoted_service.service_id, tag_list: @promoted_service.tag_list, user_id: @promoted_service.user_id }
    end

    assert_redirected_to promoted_service_path(assigns(:promoted_service))
  end

  test "should show promoted_service" do
    get :show, id: @promoted_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promoted_service
    assert_response :success
  end

  test "should update promoted_service" do
    patch :update, id: @promoted_service, promoted_service: { image: @promoted_service.image, location: @promoted_service.location, name: @promoted_service.name, price: @promoted_service.price, service_id: @promoted_service.service_id, tag_list: @promoted_service.tag_list, user_id: @promoted_service.user_id }
    assert_redirected_to promoted_service_path(assigns(:promoted_service))
  end

  test "should destroy promoted_service" do
    assert_difference('PromotedService.count', -1) do
      delete :destroy, id: @promoted_service
    end

    assert_redirected_to promoted_services_path
  end
end
