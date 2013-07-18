class CheckInController < ApplicationController
  layout 'logged_out'
  def welcomeback
    if params[:code].blank?
      redirect_to root_path
    else
      @user = User.where(validate_code: params[:code]).first
      if @user.nil?
        @ok = false
      else
        if @user.status == 'validating'
          @user.update_attributes :status => "normal", :check_date_time => DateTime.now
          @user.update_attribute :validate_code, ""
          @ok = true
        else # status = died !!??
          @ok = false
        end
      end
    end
  end
end
