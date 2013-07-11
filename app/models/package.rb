class Package < ActiveRecord::Base

  attr_accessible :name, :description, :encrypted_key, :custom_key
  attr_accessor :key
  validates :name, :presence => true, :length => 3...50
  validates :user_id, :presence => true
  validates :name, :uniqueness => {:scope => :user_id}

  validates_length_of :key, :is => 32, :if => lambda { |i| i.custom_key == true }

  belongs_to :user
  has_many :items, :dependent => :destroy

  #has_one :recipient

  # before_save :create_aes_key, :if => lambda { |i| i.custom_key == false }

  def create_aes_key
    key = OpenSSL::Cipher.new("AES-256-ECB").random_key
    # key = Digest::MD5.hexdigest("#{Time.now} ... #{self.name}")
    self.encrypted_key = Base64.encode64(key)
  end

  after_destroy :delete_from_s3

  def delete_from_s3 # put in controller ?
    Thread.new do
      s3_bucket_delete("#{ENV['s3_bucket_prefix']}#{self.id}")
    end
  end
end
