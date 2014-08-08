require 'test_helper'

class UserIdentificationsControllerTest < ActionController::TestCase
  setup do
    @user_identification = user_identifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_identifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_identification" do
    assert_difference('UserIdentification.count') do
      post :create, user_identification: { address: @user_identification.address, city: @user_identification.city, country: @user_identification.country, id_photo: @user_identification.id_photo, real_name: @user_identification.real_name, recent_photo: @user_identification.recent_photo, zip_code: @user_identification.zip_code }
    end

    assert_redirected_to user_identification_path(assigns(:user_identification))
  end

  test "should show user_identification" do
    get :show, id: @user_identification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_identification
    assert_response :success
  end

  test "should update user_identification" do
    patch :update, id: @user_identification, user_identification: { address: @user_identification.address, city: @user_identification.city, country: @user_identification.country, id_photo: @user_identification.id_photo, real_name: @user_identification.real_name, recent_photo: @user_identification.recent_photo, zip_code: @user_identification.zip_code }
    assert_redirected_to user_identification_path(assigns(:user_identification))
  end

  test "should destroy user_identification" do
    assert_difference('UserIdentification.count', -1) do
      delete :destroy, id: @user_identification
    end

    assert_redirected_to user_identifications_path
  end
end
