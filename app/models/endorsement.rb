class Endorsement < ActiveRecord::Base
  include PublicActivity::Common
  
  belongs_to :writer, :class_name => 'User'
  belongs_to :endorsed, :class_name => 'User'
  
  scope :published, -> { where(approved: true) }
  
  def self.users_endorsement(user)
    self.where("user_id = ? ", user)
  end
  
  validate :endorsement_quota, :on => :create  
  
  def endorsement_quota
    if writer.endorsements.today.count >= 10
      redirect_to root_path
    end
  end
  
end
