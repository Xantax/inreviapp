class Message < ActiveRecord::Base
  belongs_to :conversation, :counter_cache => true
  belongs_to :sender, :foreign_key => :sender_id, :class_name => 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, :class_name => 'User'
  
  after_save :update_post_last_comment_at
  
  private
  
  def update_post_last_comment_at
    self.conversation.touch(:content_changed_at) if self.conversation
  end
  
end
