class UserIdentificationsController < ApplicationController
  before_action :user_count_identifications, only: [:new, :create]
  before_action :before_user_count_phone_code, only: [:new, :create]
  before_action :before_phone_correct, only: [:new, :create]
  before_action :authenticate_user!

  def new
    @user_identification = UserIdentification.new
  end

  def create
    @user_identification = UserIdentification.new(user_identification_params)

    respond_to do |format|
      if @user_identification.save
        format.html { redirect_to root_path, notice: 'Thank you. We are now verifying your profile.' }
        format.json { render :show, status: :created, location: @user_identification }
      else
        format.html { render :new }
        format.json { render json: @user_identification.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user_identification
      @user_identification = UserIdentification.find(params[:id])
    end

    def user_identification_params
      params.require(:user_identification).permit(:real_name, :city, :zip_code, :address, :country, :id_photo, :recent_photo, :user_id)
    end
end
