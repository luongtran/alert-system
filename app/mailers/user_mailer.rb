class UserMailer < ActionMailer::Base
  default :from => ENV['MAIL_SENDER_ADDR']

  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end
  def validate_email(user)
    @user = user
    @validate_mail = MailTemplate.find_all_by_email_type("validate_email")

    mail(:to => @user.email, :subject => @validate_mail.subject)
  end
end
