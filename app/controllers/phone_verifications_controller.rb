class PhoneVerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_phone_verification, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: :destroy
  before_action :user_count, only: [:new, :create]
  before_action :before_email, only: [:new, :create]
  before_action :authenticate_user!

  def new
    @phone_verification = PhoneVerification.new
  end

  def create
    @phone_verification = PhoneVerification.new(phone_verification_params)

    respond_to do |format|
      if @phone_verification.save
        
          client = Twilio::REST::Client.new('ACfae1e12a1f052f3fcbc91d029509b18f', '4785b63938b2761c7be6f8a1522fb07c')
          # Create and send an SMS message
          client.account.sms.messages.create(
          from: "+14849860545",
          to: @phone_verification.number,
          body: "Hello from Inrevi. This is your verification code: #{current_user.sms_code}"
          )
        
        format.html { redirect_to "/phone_codes/new" }
        format.json { render :show, status: :created, location: @phone_verification } 
      else
        format.html { render :new }
        format.json { render json: @phone_verification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone_verification.destroy
    respond_to do |format|
      format.html { redirect_to '/phone_verifications/new' }
      format.json { head :no_content }
    end
  end

  private

    def set_phone_verification
      @phone_verification = PhoneVerification.find(params[:id])
    end

    def phone_verification_params
      params.require(:phone_verification).permit(:number, :user_id)
    end
  
    def user_count
      if current_user.phone_verifications.count == 1
        redirect_to root_path
      end
    end
  
    def require_permission
      if current_user != PhoneVerification.find(params[:id]).user
        redirect_to root_path
      end
    end
  
    def before_email
      if current_user.confirmed_at.blank?
        redirect_to root_path
      end
    end
  
end
