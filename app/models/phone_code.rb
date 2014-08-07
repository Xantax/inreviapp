class PhoneCode < ActiveRecord::Base
  belongs_to :user
  
  validates :code, length: { minimum: 6 }
end
