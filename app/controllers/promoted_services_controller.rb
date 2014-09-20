class PromotedServicesController < ApplicationController
  before_action :set_promoted_service, only: [:show]
  #before_action :only_admin, except: [:show]
  #before_action :must_be_completely_verified, except: [:show]

  def show
    @promoted_service.increment!(:clicks)
    redirect_to @promoted_service.service
  end

  def new
    @service = Service.find(params[:service_id])
    @promoted_service = PromotedService.new
  end

  def create
    @service = Service.find(params[:service_id])
    @promoted_service = @service.promoted_services.create(promoted_service_params)

    respond_to do |format|
      if @promoted_service.save
        format.html { redirect_to root_url, notice: 'Your service is now promoted' }
        format.json { render :show, status: :created, location: @promoted_service }
      else
        format.html { render :new }
        format.json { render json: @promoted_service.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_promoted_service
      @promoted_service = PromotedService.find(params[:id])
    end
  
    def promoted_service_params
      params.require(:promoted_service).permit(:name, :image, :location, :tag_list, :price, :user_id, :service_id, :set_clicks)
    end
end
