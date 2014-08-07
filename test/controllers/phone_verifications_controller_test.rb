require 'test_helper'

class PhoneVerificationsControllerTest < ActionController::TestCase
  setup do
    @phone_verification = phone_verifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_verifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_verification" do
    assert_difference('PhoneVerification.count') do
      post :create, phone_verification: { number: @phone_verification.number, user_id: @phone_verification.user_id }
    end

    assert_redirected_to phone_verification_path(assigns(:phone_verification))
  end

  test "should show phone_verification" do
    get :show, id: @phone_verification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone_verification
    assert_response :success
  end

  test "should update phone_verification" do
    patch :update, id: @phone_verification, phone_verification: { number: @phone_verification.number, user_id: @phone_verification.user_id }
    assert_redirected_to phone_verification_path(assigns(:phone_verification))
  end

  test "should destroy phone_verification" do
    assert_difference('PhoneVerification.count', -1) do
      delete :destroy, id: @phone_verification
    end

    assert_redirected_to phone_verifications_path
  end
end
