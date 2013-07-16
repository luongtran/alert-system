class RegistrationsController < Devise::RegistrationsController
  layout :resolve_layout

  def new
    @plan = params[:plan]
    if @plan && ENV["ROLES"].include?(@plan)
      @signature = Recurly.js.sign :subscription => {:plan_code => @plan}
      super
    else
      redirect_to pricing_path, :notice => 'Please select a subscription plan !'
    end
  end

  def create
    @plan = params[:plan] # use for customize form
    super
  end

  def update_plan
    @user = current_user
    old_role = current_user.roles.first.id
    #role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    new_role = Role.find(params[:role_ids])
    if @user.update_plan(new_role)
      # Delete package
      have = current_user.packages.count
      max = Role.find(new_role).maximum_packages
      if have > max
        Package.where(:user_id => current_user.id).all(:order => 'created_at', :limit => (have - max)).each do |p|
          p.destroy
        end
      end
      redirect_to :back, :notice => "Your plan updated successfully, #{have - max} package(s) has been deleted !"
    else
      flash.alert = 'Unable to update plan.'
      redirect_to :back
    end
  end

  private
  def build_resource(*args)
    super
    if params[:plan]
      # resource.skip_check_recurly = true if params[:plan]=='free' # Free user không cần check_recurly
      resource.add_role(params[:plan])
    end
    resource.customer_id ||= SecureRandom.uuid
  end

  def resolve_layout
    case action_name
      when "new"
        "logged_out"
      when "create"
        "logged_out"
      else
        "application"
    end
  end

end
