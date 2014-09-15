class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :offer
  belongs_to :convoable, polymorphic: true
  has_many :messages
  has_many :buy_requests
  has_many :orders
  has_many :reviews
  
  belongs_to :recipient,
   :class_name => 'User',
   :primary_key => 'user_id',
   :foreign_key => 'recipient_id'
  
  validate :conversation_quota, :on => :create
  
  def conversation_quota
    if user.conversations.today.count >= 5
      redirect_to root_path
    end
  end
  
  # conversation has at least 1 message a.k.a user contacted a seller
  def self.valid_conversation
    self.where("messages_count > 0")
  end
  
  # Inbox also contains sent messages
  def self.users_conversation
    self.valid_conversation.where("user_id = ? OR recipient_id = ?", User.current.id, User.current.id)
  end
  
  # Order by the last updated
  def self.ordered_conversations
    self.users_conversation.order('content_changed_at DESC')
  end
  
  # Count unread messages
  def self.count_unread_conversations
    self.users_conversation.where('content_changed_at >= ?', User.current.last_visited_inbox_at).count
  end
  
end
