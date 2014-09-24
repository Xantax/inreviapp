class PerTemporal < ActiveRecord::Base
  has_many :rents
  has_many :promoted_rents
  has_many :works
  has_many :promoted_works
  has_many :services
  has_many :promoted_services
end
