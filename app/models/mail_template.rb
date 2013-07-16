class MailTemplate < ActiveRecord::Base
  attr_accessible :name, :subject, :body
  NAMES = ['Confirmation', 'Reset Password', 'Validate', 'Expire', 'Disabled Account', 'Recipient']

  validates_presence_of :name, :body, :subject
  validates_uniqueness_of :name

end
