class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :update, :destroy]
  #before_action :must_be_completely_verified

  def show
    redirect_to root_url
  end

  def new
    @alert = Alert.new
  end

  def edit
  end

  def create
    @alert = Alert.new(alert_params)

    respond_to do |format|
      if @alert.save
        
        @alert.create_activity :create, owner: current_user
        
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @alert }
      else
        format.html { render :new }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @alert.update(alert_params)
        format.html { redirect_to root_url }
        format.json { render :show, status: :ok, location: @alert }
      else
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private

    def set_alert
      @alert = Alert.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:body, :user_id, :image)
    end
  
    def require_permission
      if current_user != Alert.find(params[:id]).user
        redirect_to root_path
      end
    end
end
