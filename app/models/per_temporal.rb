class PerTemporal < ActiveRecord::Base
  has_many :rents
  has_many :promoted_rents
  has_many :works
  has_many :promoted_works
end
