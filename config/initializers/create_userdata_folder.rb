Dir.mkdir "#{Rails.root.to_s}/tmp"  unless File.directory? "#{Rails.root.to_s}/tmp"
Dir.mkdir "#{Rails.root.to_s}/tmp/userdata"  unless File.directory? "#{Rails.root.to_s}/tmp/userdata"
ENV['temp_folder_path'] = "#{Rails.root.to_s}/tmp/userdata/"
ENV['s3_bucket_prefix'] = "send-switch-package"