class BuyRequestsController < ApplicationController
  before_action :set_buy_request, only: [:show, :edit, :update, :destroy]

  def index
    @buy_requests = BuyRequest.all
  end

  def show
  end

  def new
    @buy_request = BuyRequest.new
  end

  def edit
  end

  def create
    @buy_request = BuyRequest.new(buy_request_params)

    respond_to do |format|
      if @buy_request.save
        format.html { redirect_to @buy_request, notice: 'Buy request was successfully created.' }
        format.json { render :show, status: :created, location: @buy_request }
      else
        format.html { render :new }
        format.json { render json: @buy_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @buy_request.update(buy_request_params)
        format.html { redirect_to @buy_request, notice: 'Buy request was successfully updated.' }
        format.json { render :show, status: :ok, location: @buy_request }
      else
        format.html { render :edit }
        format.json { render json: @buy_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @buy_request.destroy
    respond_to do |format|
      format.html { redirect_to buy_requests_url, notice: 'Buy request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_buy_request
      @buy_request = BuyRequest.find(params[:id])
    end

    def buy_request_params
      params.require(:buy_request).permit(:user_id, :conversation_id, :offer_id)
    end
end
