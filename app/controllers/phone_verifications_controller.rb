class PhoneVerificationsController < ApplicationController
  before_action :set_phone_verification, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    @phone_verifications = PhoneVerification.all
  end

  def show
  end

  def new
    @phone_verification = PhoneVerification.new
  end

  def edit
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
        
        format.html { redirect_to "/phone_codes/new", notice: 'Check you phone!' }
        format.json { render :show, status: :created, location: @phone_verification } 
      else
        format.html { render :new }
        format.json { render json: @phone_verification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone_verification.update(phone_verification_params)
        format.html { redirect_to @phone_verification, notice: 'Phone verification was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_verification }
      else
        format.html { render :edit }
        format.json { render json: @phone_verification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone_verification.destroy
    respond_to do |format|
      format.html { redirect_to phone_verifications_url, notice: 'Phone verification was successfully destroyed.' }
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
end
