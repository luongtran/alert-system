class Item < ActiveRecord::Base
  include ItemsHelper
  attr_accessible :description, :name, :item_type, :text_content, :file_name

  attr_accessor :aes_key, :file

  validates :name, :presence => true, :length => 3...30

  validates_uniqueness_of :name

  validates :item_type, :presence => true

  validates :text_content, :presence => true, :if => lambda { |i| i.item_type == 1 }

  validates :file_name, :presence => true, :if => lambda { |i| i.item_type == 2 }

  validates_uniqueness_of :file_name, :scope => :package_id, :if => lambda { |i| i.item_type == 2 }

  belongs_to :package

  before_save :encrypt_item_contents

  before_destroy :delete_from_s3, :if => lambda { |i| i.item_type == 2 }

  def encrypt_item_contents

    if self.item_type == 1 # Text item
      # 1st: encrypt plain text with AES-256-ECB
      step1 = text_AES_Encryptor(self.text_content, self.aes_key)

      # 2nd: encrypt above string with Base64
      step2 = Base64.encode64(step1)

      # 3rd: update attribute
      self.text_content = step2
    else # File item
      # Create temp folder if not exist
      temp_folder_path = ENV['temp_folder_path']+"#{self[:package_id]}"
      unless File.directory? temp_folder_path
        Dir.mkdir(temp_folder_path, 0777)
      end

      # Save original file
      origin_file_path = File.join(temp_folder_path, self.file_name)
      File.open(origin_file_path, "wb") { |f| f.write(self.file.read) }

      # Upload to s3 and encrypt file at the same time
      s3_uploader(origin_file_path, "#{ENV['s3_bucket_prefix']}#{self[:package_id]}", self.aes_key)

      # Delete original file
      File.delete(origin_file_path)
    end
  end

  def filename=(new_filename)
    write_attribute(:file_name, sanitize_filename(new_filename))
  end

  def delete_from_s3
    s3 = AWS::S3.new
    obj = s3.buckets["#{ENV['s3_bucket_prefix']}#{self[:package_id]}"].objects[self.file_name]
    obj.delete
  end

  def s3_url
    s3 = AWS::S3.new
    obj = s3.buckets["#{ENV['s3_bucket_prefix']}#{self[:package_id]}"].objects[self.file_name]
    obj.url_for(:read, :authenticated => true, :expires => 60).to_s
  end

  private
  def sanitize_filename(filename)
    # Get only the filename, not the whole path
    just_filename = File.basename(filename)
    just_filename.gsub(/[^\w\.\-]/, '_')
  end


end
