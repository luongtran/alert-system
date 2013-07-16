class RecipientMailer < ActionMailer::Base
  default :from => ENV['MAIL_SENDER_ADDR']

  def package_email(package, recipient)
    @package = package
    @recipient = recipient
    @user = User.find(@package.user_id)
    # Find package's recipient
    mail(:to => @recipient.email, :subject => "Package from Alert System")
  end
end