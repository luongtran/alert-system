class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_default_control_label
  before_filter :admin_site, :only => [:packages, :items]
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    @user = User.find(current_user.id)
    if current_user.has_role? :admin
      users_path
    else
      @user.update_attributes(:status => 'normal', :check_date_time => DateTime.now)
      dashboard_path
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

  private
  def admin_site
    if current_user.has_role? :admin
      redirect_to users_path
    end
  end

end
