module ItemsHelper
  require 'openssl'
  require "base64"

  def text_AES_Decryptor(encrypted_data, key)
    aes = OpenSSL::Cipher::AES256.new(:ECB)
    aes.decrypt
    aes.key = key
    
    #aes.iv = iv if iv != nil
    aes.update(encrypted_data) + aes.final
  end

  def text_AES_Encryptor(data, key)
    aes = OpenSSL::Cipher::AES256.new(:ECB)
    aes.encrypt
    aes.key = key
    #aes.iv = iv if iv != nil
    aes.update(data) + aes.final
  end

  def file_AESEncryptor(source_path, key, dest_file_path)
    aes = OpenSSL::Cipher::AES256.new(:CBC)
    aes.encrypt
    aes.key = key
    buffer = "";
    File.open(dest_file_path, "wb") do |outf|
      File.open(source_path, "rb") do |inf|
        while inf.read(4096, buffer)
          outf << aes.update(buffer)
        end
        outf << aes.final
      end
    end

  end

  def file_AESDecryptor(source_path, key, dest_file_path)
    aes = OpenSSL::Cipher::AES256.new(:CBC)
    aes.decrypt
    aes.key = key
    buffer = "";
    File.open(dest_file_path, "wb") do |outf|
      File.open(source_path, "rb") do |inf|
        while inf.read(4096, buffer)
          outf << aes.update(buffer)
        end
        outf << aes.final
      end
    end
  end

  def file_DES_Encryptor(source_path, key, dest_file_path)
    cipher = OpenSSL::Cipher.new('DES-ECB')
    cipher.encrypt
    cipher.key = key
    buffer = "";
    File.open(dest_file_path, "wb") do |outf|
      File.open(source_path, "rb") do |inf|
        while inf.read(4096, buffer)
          outf << cipher.update(buffer)
        end
        outf << cipher.final
      end
    end
  end

  def file_DES_Decryptor(source_path, key, dest_file_path)
    cipher = OpenSSL::Cipher.new('DES-ECB')
    cipher.decrypt
    cipher.key = key
    buffer = "";
    File.open(dest_file_path, "wb") do |outf|
      File.open(source_path, "rb") do |inf|
        while inf.read(4096, buffer)
          outf << cipher.update(buffer)
        end
        outf << cipher.final
      end
    end
  end

  def text_DES_Encryptor(source_string, key)
    cipher = OpenSSL::Cipher.new('DES-ECB')
    cipher.encrypt
    cipher.key = key
    #aes.iv = iv if iv != nil
    cipher.update(source_string) + cipher.final
  end

  def text_DES_Decryptor(source_string, key)
    cipher = OpenSSL::Cipher.new('DES-ECB')
    cipher.decrypt
    cipher.key = key
    #aes.iv = iv if iv != nil
    cipher.update(source_string) + cipher.final
  end
end


def s3_bucket_delete(bucket_name)
  s3 = AWS::S3.new
  bucket = s3.buckets.create(bucket_name)
  bucket.delete
end

def s3_uploader(source_file_path, bucket_name, aeskey)
    f = File.open(source_file_path, 'rb')
    s3 = AWS::S3.new
    bucket = s3.buckets.create(bucket_name)
    obj = bucket.objects["#{File.basename(source_file_path)}"]
    obj.write(f, :encryption_key => aeskey)
    f.close

 
end

def s3_downloader(bucket_name, file_name, aes_key = nil)
  s3 = AWS::S3.new
  bucket = s3.buckets.create(bucket_name)
  obj = bucket.objects[file_name]
  file = File.open("#{ENV['temp_folder_path']}/#{file_name}", 'wb')
  if aes_key.nil?
    data = obj.read
  else
    data = obj.read(:encryption_key => aes_key)
  end
  return data
end


