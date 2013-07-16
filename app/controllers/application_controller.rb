class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :blocked?
  before_filter :set_default_control_label
  before_filter :admin_site, :only => [:packages, :items]
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    if !resource.is_a?(User)
      admin_dashboard_path
    else
      @user = User.find(current_user.id)
      if current_user.has_role? :admin
        users_path
        sign_in
      else
        if resource.is_a?(User) && resource.blocked?
          sign_out resource
          flash[:notice] = "Your account has been blocked for you didn't validated after ...."
          root_path
        else
          @user.update_attributes(:status => 'normal', :check_date_time => DateTime.now)
          dashboard_path
        end
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


  private
  def admin_site
    if current_user.has_role? :admin
      redirect_to users_path
    end
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
