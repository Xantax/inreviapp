class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :email, email: { disposable: true }
     
  mount_uploader :image, ImageUploader
  
  has_many :phone_verifications
  has_many :phone_codes
  has_many :user_identifications
  
end
