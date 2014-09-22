class PromotedRent < ActiveRecord::Base
  belongs_to :user
  belongs_to :rent
end
