class Service < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
    
  include PgSearch
    pg_search_scope :search_by_name, :against => [:name, :location], :using => {
    :tsearch => {:prefix => true, :any_word => true}
      },
      :associated_against => {
      :tags => [:name]
      }
  
  validates :price, numericality: { :greater_than => 0, :less_than_or_equal_to => 100000000 }
  
  def self.search(search)
    Service.search_by_name(search)
  end
  
  scope :published, -> { where(deleted: false) }
  
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :promoted_offers, as: :promotable
  has_many :conversations, as: :convoable
  has_many :buy_requests, as: :buyable
  has_many :orders, as: :orderable
  has_many :reviews, as: :reviewable
  
  mount_uploader :image, ImageUploader
  
  validates :name, length: { maximum: 120 }
  validates :description, length: { maximum: 10000 }
  validates :image, presence: true
  validates :user_id, presence: true
  
  validate :user_quota, :on => :create
  
  def user_quota
    if user.services.today.count >= 4
      errors.add(:base, "You cannot create more offers for now (SPAM prevention)")
    end
  end
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).offers
  end
  
  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
end