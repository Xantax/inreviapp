class PhoneCodesController < ApplicationController
  before_action :set_phone_code, only: [:show, :edit, :update, :destroy]
  before_action :only_admin, only: [:edit, :update, :destroy]
  before_action :user_count, only: [:new, :create]
  before_action :authenticate_user!

  def new
    @phone_code = PhoneCode.new
  end

  def edit
  end

  def create
    @phone_code = PhoneCode.new(phone_code_params)

    respond_to do |format|
      if @phone_code.save
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @phone_code }
      else
        format.html { render :new }
        format.json { render json: @phone_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @phone_code.update(phone_code_params)
        format.html { redirect_to @phone_code, notice: 'Phone code was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_code }
      else
        format.html { render :edit }
        format.json { render json: @phone_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @phone_code.destroy
    respond_to do |format|
      format.html { redirect_to phone_codes_url, notice: 'Phone code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_phone_code
      @phone_code = PhoneCode.find(params[:id])
    end

    def phone_code_params
      params.require(:phone_code).permit(:code, :user_id)
    end
  
    def user_count
      if current_user.phone_codes.count == 1
        redirect_to root_path
      end
    end
  
    def only_admin
      unless current_user.admin
        redirect_to root_path
      end
    end
  
end
