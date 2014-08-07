class PhoneCodesController < ApplicationController
  before_action :set_phone_code, only: [:show, :edit, :update, :destroy]

  # GET /phone_codes
  # GET /phone_codes.json
  def index
    @phone_codes = PhoneCode.all
  end

  # GET /phone_codes/1
  # GET /phone_codes/1.json
  def show
  end

  # GET /phone_codes/new
  def new
    @phone_code = PhoneCode.new
  end

  # GET /phone_codes/1/edit
  def edit
  end

  # POST /phone_codes
  # POST /phone_codes.json
  def create
    @phone_code = PhoneCode.new(phone_code_params)

    respond_to do |format|
      if @phone_code.save
        format.html { redirect_to @phone_code, notice: 'Phone code was successfully created.' }
        format.json { render :show, status: :created, location: @phone_code }
      else
        format.html { render :new }
        format.json { render json: @phone_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_codes/1
  # PATCH/PUT /phone_codes/1.json
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

  # DELETE /phone_codes/1
  # DELETE /phone_codes/1.json
  def destroy
    @phone_code.destroy
    respond_to do |format|
      format.html { redirect_to phone_codes_url, notice: 'Phone code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_code
      @phone_code = PhoneCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_code_params
      params.require(:phone_code).permit(:code, :user_id)
    end
end
