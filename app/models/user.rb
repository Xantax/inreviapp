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
  
  def creditz
    self.current.credit.to_i
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
  
end
