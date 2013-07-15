class RecipientMailer < ActionMailer::Base
  default :from => "Alert System Stuff <alert-system@example.com>"

  def package_email(package, recipient)
    @package = package
    @recipient = recipient
    @user = User.find(@package.user_id)
    # Find package's recipient
    mail(:to => @recipient.email, :subject => " Send Switch Package ")
  end

end