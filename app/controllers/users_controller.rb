class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    if @user.update_attributes(params[:user])
      @user.update_plan(role) unless role.nil?
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def edit_billing
    account = Recurly::Account.find(current_user.customer_id)
    @billing_infor = account.billing_info
  rescue Recurly::Resource::NotFound => e
    flash[:notice] = "Your account not found in Recurly !"
    redirect_to :back
  end

  def update_billing
    account = Recurly::Account.find(current_user.customer_id)
    account.billing_info = params[:billing_inf]
    account.billing_info.save
    redirect_to :back
  rescue Recurly::Resource::Invalid => e
    flash[:notice] = "Billing infor update failed!"
    redirect_to dashboard_path
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
