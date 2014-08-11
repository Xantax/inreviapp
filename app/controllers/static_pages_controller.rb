class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:buycredit]
  
  def home
    @promoted_offers = PromotedOffer.where('created_at >= :two_days_ago', two_days_ago: Time.now - 2.days).order('created_at DESC')
  end
  
  def terms
  end
  
  def buycredit
  end
end
