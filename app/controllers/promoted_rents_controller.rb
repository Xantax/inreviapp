class PromotedRentsController < ApplicationController
  before_action :set_promoted_rent, only: [:show, :edit, :update, :destroy]

  # GET /promoted_rents
  # GET /promoted_rents.json
  def index
    @promoted_rents = PromotedRent.all
  end

  # GET /promoted_rents/1
  # GET /promoted_rents/1.json
  def show
  end

  # GET /promoted_rents/new
  def new
    @promoted_rent = PromotedRent.new
  end

  # GET /promoted_rents/1/edit
  def edit
  end

  # POST /promoted_rents
  # POST /promoted_rents.json
  def create
    @promoted_rent = PromotedRent.new(promoted_rent_params)

    respond_to do |format|
      if @promoted_rent.save
        format.html { redirect_to @promoted_rent, notice: 'Promoted rent was successfully created.' }
        format.json { render :show, status: :created, location: @promoted_rent }
      else
        format.html { render :new }
        format.json { render json: @promoted_rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promoted_rents/1
  # PATCH/PUT /promoted_rents/1.json
  def update
    respond_to do |format|
      if @promoted_rent.update(promoted_rent_params)
        format.html { redirect_to @promoted_rent, notice: 'Promoted rent was successfully updated.' }
        format.json { render :show, status: :ok, location: @promoted_rent }
      else
        format.html { render :edit }
        format.json { render json: @promoted_rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promoted_rents/1
  # DELETE /promoted_rents/1.json
  def destroy
    @promoted_rent.destroy
    respond_to do |format|
      format.html { redirect_to promoted_rents_url, notice: 'Promoted rent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promoted_rent
      @promoted_rent = PromotedRent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promoted_rent_params
      params.require(:promoted_rent).permit(:name, :location, :tag_list, :price, :image, :quantity, :user_id, :rent_id, :clicks, :set_clicks, :sell, :unavailable, :temporal_id, :per_temporal_id)
    end
end
