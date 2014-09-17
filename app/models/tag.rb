class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :offers, through: :taggings
  has_many :services, through: :taggings
  has_many :jobs, through: :taggings
end
