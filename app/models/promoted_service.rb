class PromotedService < ActiveRecord::Base

  include PgSearch
    pg_search_scope :search_by_name, :against => [:name, :location, :tag_list], :using => {
    :tsearch => {:prefix => true, :any_word => true}
      }
  
  def self.search(search)
    PromotedService.search_by_name(search)
  end
  
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :service
  
  scope :published, -> { where('clicks <= set_clicks') }
  
  validates :set_clicks, numericality: 
    { only_integer: true, :greater_than => 0, :less_than_or_equal_to => 100000 }
  
end
