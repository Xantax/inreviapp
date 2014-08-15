class Offer < ActiveRecord::Base

  scope :published, -> { where(deleted: false) }
  
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :promoted_offers
  has_many :conversations
  has_many :buy_requests
  has_many :orders
  
  mount_uploader :image, ImageUploader
  
  validates :name, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :image, presence: true
  validates :user_id, presence: true
  
  validate :user_quota, :on => :create
  
  def user_quota
    if user.offers.today.count >= 5
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
