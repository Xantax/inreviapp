class Job < ActiveRecord::Base
  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
    
  include PgSearch
    pg_search_scope :search_by_name, :against => [:name, :location], :using => {
    :tsearch => {:prefix => true, :any_word => true}
      },
      :associated_against => {
      :tags => [:name]
      }
  
  def self.search(search)
    Job.search_by_name(search)
  end
  
  scope :published, -> { where(deleted: false) }
  
  belongs_to :user
  has_many :promoted_offers, as: :promotable
  has_many :conversations, as: :convoable
  has_many :buy_requests, as: :buyable
  has_many :orders, as: :orderable
  has_many :reviews, as: :reviewable
  
  mount_uploader :image, ImageUploader
  
  validates :name, length: { maximum: 120 }
  validates :description, length: { maximum: 10000 }
  validates :user_id, presence: true
  
  validate :user_quota, :on => :create
  
  def user_quota
    if user.jobs.today.count >= 4
      errors.add(:base, "You cannot create more for now (SPAM prevention)")
    end
  end

end
