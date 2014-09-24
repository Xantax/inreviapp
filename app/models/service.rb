class Service < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
    
  include PgSearch
    pg_search_scope :search_by_name, :against => [:name, :location, :tag_list], :using => {
    :tsearch => {:prefix => true, :any_word => true}
      }
  
  validates :price, numericality: { :greater_than => 0, :less_than_or_equal_to => 100000000 }
  
  def self.search(search)
    Service.search_by_name(search)
  end
  
  scope :published, -> { where(deleted: false) }
  
  belongs_to :user
  belongs_to :per_temporal
  has_many :promoted_services
  has_many :conversations, as: :convoable
  has_many :reviews, as: :reviewable
  
  mount_uploader :image, ImageUploader
  
  validates :name, length: { maximum: 120 }
  validates :description, length: { maximum: 10000 }
  validates :user_id, presence: true
  
  validate :user_quota, :on => :create
  
  def user_quota
    if user.services.today.count >= 4
      errors.add(:base, "You cannot create more offers for now (SPAM prevention)")
    end
  end
  
end