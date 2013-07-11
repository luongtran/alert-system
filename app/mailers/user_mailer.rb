class UserMailer < ActionMailer::Base
  default :from => "Send Switch Stuff <send-switch@example.com>"

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end
  
  def validate_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Are you still alive ?")
  end
end
