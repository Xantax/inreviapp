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
  
  has_many :conversations
  has_many :messages, :through => :conversations

  
  has_many :offers do
    def today
    where(:created_at => (Time.now.beginning_of_day..Time.now))
    end
  end 
  
end
