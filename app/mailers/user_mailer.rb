class UserMailer < ActionMailer::Base
  default :from => ENV['MAIL_SENDER_ADDR']

  def expire_email(user)
    mail(:to => user.email, :subject => "Your subscription has been cancelled")
  end
  def validate_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Are you still alive ?")
  end
end
