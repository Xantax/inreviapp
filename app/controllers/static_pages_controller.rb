class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:buycredit]
  
  def home
  end
  
  def terms
  end
  
  def buycredit
  end
end
