class User < ActiveRecord::Base
  cattr_accessor :current 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :email, email: { disposable: true }
     
  mount_uploader :image, ImageUploader
  
  has_many :phone_verifications
  has_many :phone_codes
  has_many :user_identifications
  has_many :promoted_offers
  has_many :buy_requests
  has_many :orders
  has_many :reviews, :through => :offers
  
  has_many :conversations
  has_many :messages, :through => :conversations
  
  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
  
  has_many :offers do
    def today
    where(:created_at => (Time.now.beginning_of_day..Time.now))
    end
  end
  
  has_many :conversations do
    def today
      where(:created_at => (Time.now.beginning_of_day..Time.now))
    end
  end
  
  def remember_me
    true
  end
  
  # Find PromotedOffers created by current_user
  def all_promos
    User.current.promoted_offers.each do |promo|
      promo
    end
  end
  
  # Array of :set_clicks values
  def get_clickz
    all_promos.map{ |v| v.set_clicks }
  end
  
  # Sum of all set_clicks values for the current_user
  def sum_of_all
    get_clickz.inject{|sum,x| sum + x }
  end
  
  def max_num
    (User.current.credit.to_i) - (User.current.sum_of_all.to_i)
  end
  
end
