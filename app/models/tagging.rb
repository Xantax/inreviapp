class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  belongs_to :offer
end
