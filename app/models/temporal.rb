class Temporal < ActiveRecord::Base
  has_many :rents
  has_many :promoted_rents
  has_many :works
  has_many :promoted_works
  validates_uniqueness_of :name
end
