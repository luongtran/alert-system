class RecipientMailer < ActionMailer::Base
  default :from => "Send Switch Stuff <send-switch@example.com>"

  def package_email(package,recipient)
    @package = package
    @recipient = recipient
    @user = User.find(@package.user_id)
    # Find package's recipient
    puts "\n\n____Send package mai________\n\n"
    mail(:to => @recipient.email, :subject => " Send Switch Package ")
  end

end