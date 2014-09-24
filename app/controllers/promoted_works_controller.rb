class PromotedWorksController < ApplicationController
  before_action :set_promoted_work, only: [:show]
  before_action :only_admin, except: [:show]
  before_action :must_be_completely_verified, except: [:show]

  def show
    @promoted_work.increment!(:clicks)
    redirect_to @promoted_work.work
  end

  def new
    @work = Work.find(params[:work_id])
    @promoted_work = PromotedWork.new
  end

  def create
    @work = Work.find(params[:work_id])
    @promoted_work = @work.promoted_works.create(promoted_work_params)

    respond_to do |format|
      if @promoted_work.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @promoted_work }
      else
        format.html { render :new }
        format.json { render json: @promoted_work.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_promoted_work
      @promoted_work = PromotedWork.find(params[:id])
    end

    def promoted_work_params
      params.require(:promoted_work).permit(:name, :location, :tag_list, :price, :image, :quantity, :user_id, :work_id, :clicks, :set_clicks, :temporal_id, :per_temporal_id)
    end
end
