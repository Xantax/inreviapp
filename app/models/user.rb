class User < ActiveRecord::Base
  before_create :give_code
  
  cattr_accessor :current 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  validates :email, email: { disposable: true }
     
  mount_uploader :image, ImageUploader
  
  has_many :phone_verifications
  has_many :phone_codes
  has_many :promoted_offers
  has_many :buy_requests
  has_many :orders
  has_many :reviews
  
  has_many :conversations
  has_many :messages, :through => :conversations
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
            class_name: "Relationship",
            dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
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
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def not_following?(other_user)
    other_user != self && !following?(other_user)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  private
  
  def give_code
    self.sms_code = Random.rand(100000..999999)
  end
  
end
