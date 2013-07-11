class RecipientController < ApplicationController
  layout 'logged_out'
  def get
    if params[:code].blank?
      redirect_to root_path
    else
      @package = Package.where(verify_recipient_code: params[:code]).first
      if @package.nil?
        @ok = true
      else
        @ok = false
        # Get link for download items in package
      end
    end
  end

  def delete_package


  end

  def show

  end
end
