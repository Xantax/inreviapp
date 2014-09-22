class PerTemporal < ActiveRecord::Base
  has_many :rents
  has_many :promoted_rents
end
