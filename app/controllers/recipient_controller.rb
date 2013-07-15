class RecipientController < ApplicationController
  include ItemsHelper
  layout 'logged_out'

  def get
    if params[:code].blank?
      flash[:notice] = "Page not found"
      redirect_to root_path
    else
      @package = Package.where(verify_recipient_code: params[:code]).first
      if @package.nil?
        flash[:notice] = "Page not found"
        redirect_to root_path
      else
        @ok = true
      end
    end
  end

  def delete_package


  end

  def show

  end


  def download_item
    code = params[:code]
    package_code = code[0..31]
    item_id = Integer(code.split('-')[1])

    @item = Item.find(item_id)
    @package = Package.where(:verify_recipient_code => package_code).first

    if @item.item_type != 1
      if !@package.custom_key
        aes_key = Base64.decode64(@package.encrypted_key)
        data = s3_downloader("#{ENV['s3_bucket_prefix']}#{@package.id}", @item.file_name, aes_key)
      else
        data = s3_downloader("#{ENV['s3_bucket_prefix']}#{@item[:package_id]}", @item.file_name)
      end
      if data.nil?
        flash[:notice] = "An error has occurred, please try again later !"
        redirect_to :back
      else
        send_data(data, :filename => @item.file_name, :type => @item.file_content_type)
      end
    else # Text item
      if @package.custom_key
        text_content_encrypted = Base64.decode64(@item.text_content)
      else
        temp = Base64.decode64(@item.text_content)
        key = Base64.decode64(@package.encrypted_key)
        text_content_decrypted = text_AES_Decryptor(temp, key)
        send_data(text_content_decrypted, :filename => "#{@item.name}.txt")
      end
    end
  end

end
