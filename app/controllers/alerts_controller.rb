class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_permission, only: [:edit, :update, :destroy]
  before_action :must_be_completely_verified

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
      if @alert.save        
        @alert.create_activity :create, owner: current_user
        redirect_to root_url
      else
        render :new
      end
  end

  def update
      if @alert.update(alert_params)
        redirect_to root_url
      else
        render :edit
      end
  end

  def destroy
    @alert.destroy
    redirect_to root_url
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
