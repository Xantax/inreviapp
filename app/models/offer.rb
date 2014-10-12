class Offer < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
    
  include PgSearch
  pg_search_scope :search_by_name, :against => [:name, :location, :tag_list, :barcode], :using => {
    :tsearch => {:prefix => true, :any_word => true}
      }

  validates :price, numericality: { :greater_than => 0, :less_than_or_equal_to => 100000000 }
  validates :quantity, numericality: { only_integer: true, :greater_than => 0, :less_than_or_equal_to => 100000000 }
  
  def self.search(search)
    Offer.search_by_name(search)
  end
  
  scope :published, -> { where(deleted: false) }
  
  belongs_to :user
  has_many :promoted_offers
  has_many :conversations, as: :convoable
  has_many :reviews, as: :reviewable
  
  mount_uploader :image, ImageUploader
  mount_uploader :image_a, ImageUploader
  mount_uploader :image_b, ImageUploader
  mount_uploader :image_c, ImageUploader
  mount_uploader :image_d, ImageUploader
  mount_uploader :image_e, ImageUploader
  
  validates :name, length: { maximum: 120 }
  validates :description, length: { maximum: 10000 }
  validates :user_id, presence: true
  
  validate :user_quota, :on => :create
  
  def user_quota
    if user.offers.today.count >= 10
      errors.add(:base, "You cannot create more offers for now (SPAM prevention)")
    end
  end
  
end
