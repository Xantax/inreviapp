class PhoneVerification < ActiveRecord::Base
  belongs_to :user
  validates :number, presence: true, uniqueness: true
end
