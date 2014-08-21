class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:buycredit]
  
  def home
#    if user_signed_in?
#    @promoted_offers = PromotedOffer.published.order('set_clicks DESC').paginate(:page => params[:page], :per_page => 20)
#    end
  end
  
  def terms
  end
  
  def buycredit
  end
end
