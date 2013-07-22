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

#  first_name
#  First name on the credit card/billing address
#  last_name
#  Last name on the credit card/billing address
#  address1
#  Street address line 1. This may be optional or required, depending on your address verification settings.
#  address2
#  Street address line 2
#  city
#  City
#  state
#  2-letter state or province code
#  country
#  2-letter ISO country code
### zip
#  Zip code or postal code
###  phone
#  Phone number for the billing address
### ip_address
#   User's IP address when providing billing information. Optional but very highly recommended for fraud detection.
#vat_number
#Customer's VAT Number


  def edit_billing
    account = Recurly::Account.find(current_user.customer_id)
    @billing_infor = account.billing_info
  rescue Recurly::Resource::NotFound => e
    flash[:notice] = "Your account code not found!"
    redirect_to :back
  end

  def update_billing
    account = Recurly::Account.find(current_user.customer_id)
    # validate
    # account.billing_info = params[:billing_inf]
    params[:billing_inf].each { |key, value|
      if !value.blank?
        account.billing_info[key]= value
      end
    }
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
