class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_default_control_label

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    if !resource.is_a?(User)
      admin_dashboard_path
    else
      @user = User.find(current_user.id)
      if resource.is_a?(User) && resource.blocked?
        sign_out resource
        flash[:notice] = "Your account has been blocked. We sent you an email to verify that you're still alive,
                          but you didn't verified during waiting time. So we blocked your account. Please contact admin to resolve"
        root_path
      else
        @user.update_attributes :status => 'normal', :check_date_time => DateTime.now
        dashboard_path
      end
    end
  end

  def set_default_control_label
    first = params[:controller]
    second = params[:action]
    if second == 'index'
      second = ""
    end
    @control_label = "#{first} - #{second}"
  end


  #def blocked?
  #  puts "\n\n______________blocked? method"
  #  if current_user.present? && current_user.blocked?
  #    sign_out current_user
  #    flash[:error] = "Your account has been blocked ..."
  #    root_path
  #  end
  #end


end
