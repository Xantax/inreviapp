class UserMailer < ActionMailer::Base
  default from: "support@inrevi.com"
  
  def new_message(message)
    @message = message
    @author = message.sender
    @user = message.recipient
    @offer = message.conversation.convoable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new message')
  end
  
  def new_buy_request(conversation)
    @conversation = conversation
    @author = conversation.user
    @user = conversation.convoable.user
    @offer = conversation.convoable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - You have a new request')
  end
  
  def new_order(conversation)
    @conversation = conversation
    @seller = conversation.convoable.user
    @user = conversation.user
    @offer = conversation.convoable
    @url  = 'http://www.inrevi.com/conversations'
    
    mail(to: @user.email, subject: 'Inrevi - Your request was approved by the seller')
  end
end
