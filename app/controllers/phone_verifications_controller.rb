class PhoneVerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_phone_verification, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: :destroy
  before_action :user_count_phone_verifications, only: [:new, :create]
  before_action :before_email, only: [:new, :create]
  before_action :authenticate_user!

  def new
    @geoip = GeoIP.new("#{Rails.root}/db/GeoIP.dat").country(current_user.current_sign_in_ip).country_code2.to_s
    @dial_code = Country.find_country_by_alpha2(@geoip).country_code.to_i
    @phone_verification = PhoneVerification.new(:number => "#{@dial_code}")
  end

  def create
    @phone_verification = PhoneVerification.new(phone_verification_params)

    respond_to do |format|
      if @phone_verification.save
        
          client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
          # Create and send an SMS message
          client.account.sms.messages.create(
          from: "+14849860545",
          to: "+#{@phone_verification.number}",
          body: "Hello from Inrevi. This is your verification code: #{current_user.sms_code}"
          )
        
        format.html { redirect_to real_code_user_path(current_user) }
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
  
    def require_permission
      if current_user != PhoneVerification.find(params[:id]).user
        redirect_to root_path
      end
    end
  
end
