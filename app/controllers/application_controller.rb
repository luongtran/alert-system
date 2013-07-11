class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_default_control_label
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
    @control_label = "#{params[:controller]} - #{params[:action]}"
  end
end
