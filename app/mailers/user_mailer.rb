class UserMailer < ActionMailer::Base
  default :from => "Alert System Stuff <alert-system@example.com>"

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def validate_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Are you still alive ?")
  end
end
