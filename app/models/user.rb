class User < ActiveRecord::Base
  @@max_validate_days = 7

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,
                  :card_token, :customer_id, :frequency, :status, :check_date_time, :validate_code, :blocked, :send_validate_mail_at

  attr_accessor :card_token, :skip_check_recurly

  before_create :check_recurly

  after_destroy :cancel_subscription

  validates_numericality_of :frequency, :greater_than_or_equal_to => 1

  has_many :packages, :dependent => :destroy
  has_many :items, :through => :packages


  def num_recipients
    recipients = Recipient.where('user_id = ?', self.id)
    return !recipients.blank? ? recipients.count : 0
  end

  def name
    name = "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def check_recurly
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to create your subscription. #{e.message}"
    false
  end

  def update_plan(role)
    self.role_ids = []
    self.add_role(role.name)

    if customer_id.nil?
      errors.add :base, "Unable to update your subscription."
      return false
    end
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
    unless customer.nil?
      subscription = customer.subscriptions.first
      subscription.update_attributes! :timeframe => 'now', :plan_code => role.name
    end
    true
  rescue Recurly::Resource::Invalid => e
    logger.error e.message
    errors.add :base, "Unable to update your subscription. #{e.message}"
    false
  end

  def update_recurly
    customer = Recurly::Account.find(customer_id) unless customer_id.nil?
    unless customer.nil?
      customer.email = email
      customer.first_name = first_name
      customer.last_name = last_name
      customer.save!
    end
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to update your subscription. #{e.message}"
    false
  end

  def cancel_subscription
    unless customer_id.nil?
      customer = Recurly::Account.find(customer_id)
      subscription = customer.subscriptions.first unless customer.nil?
      if (!subscription.nil?) && (subscription.state == 'active')
        subscription.cancel
      end
    end
  rescue Recurly::Resource::NotFound => e
    logger.error e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}"
    false
  end

  def expire
    UserMailer.expire_email(self).deliver
    destroy
  end

  def self.daily_checker

    number_emails_sent = 0
    @users = User.all
    @users.each do |u|
      unless u.has_role? :admin
        case u.status
          when 'normal'
             if (u.check_date_time + u.frequency.days).past?
           # if (u.check_date_time + 40).past? #Test, frequency = 60 second #
              u.update_attribute(:status, "validating")
              # Generate random vadidate code
              validate_code = Digest::SHA1.hexdigest "#{Time.now} #{u.email}"
              u.update_attribute(:validate_code, validate_code)
              # Send validate mail
              UserMailer.validate_email(u).deliver
              number_emails_sent += 1
              u.update_attribute :send_validate_mail_at, DateTime.now
            end
          when 'validating'
            unless u.send_validate_mail_at.nil?
              #if (u.send_validate_mail_at + @@max_validate_days.days).past?
              if (u.send_validate_mail_at + 3600).past? #Test validating time = 300s#
                u.update_attributes :status => 'died', :validate_code => nil, :blocked => true
                # Send package mail to reciptients
                u.packages.each do |p|
                  #unless p.items.count == 0
                  # Generate random verify code
                  verify_recipient_code = Digest::SHA1.hexdigest "#{Time.now} #{p.id}"
                  p.update_attribute :verify_recipient_code, verify_recipient_code
                  # Send mail
                  recipient = Recipient.find(p.recipient_id)
                  RecipientMailer.package_email(p, recipient).deliver
                  p.update_attribute :send_to_recipient_at, DateTime.now
                  puts "Package[#{p.id} - #{p.name}] was send to recipient[#{recipient.id} - #{recipient.name}]"
                  number_emails_sent += 1
                  #end
                end
              end
            end
          #when 'died'
        end
      end # End check role
    end
    number_emails_sent
  end
end
