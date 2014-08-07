require 'test_helper'

class PhoneCodesControllerTest < ActionController::TestCase
  setup do
    @phone_code = phone_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_code" do
    assert_difference('PhoneCode.count') do
      post :create, phone_code: { code: @phone_code.code, user_id: @phone_code.user_id }
    end

    assert_redirected_to phone_code_path(assigns(:phone_code))
  end

  test "should show phone_code" do
    get :show, id: @phone_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone_code
    assert_response :success
  end

  test "should update phone_code" do
    patch :update, id: @phone_code, phone_code: { code: @phone_code.code, user_id: @phone_code.user_id }
    assert_redirected_to phone_code_path(assigns(:phone_code))
  end

  test "should destroy phone_code" do
    assert_difference('PhoneCode.count', -1) do
      delete :destroy, id: @phone_code
    end

    assert_redirected_to phone_codes_path
  end
end
