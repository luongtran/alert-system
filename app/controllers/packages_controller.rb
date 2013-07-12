class PackagesController < ApplicationController
  require 'digest/md5'
  require 'openssl'
  before_filter :authenticate_user!
  before_filter :get_addresses, :only => [:new, :edit]

  # GET /packages
  # GET /packages.json
  respond_to :js, :html
  # GET /packages/1
  # GET /packages/1.json
  def show
    begin
      @package = current_user.packages.find(params[:id])
      @items = Item.where(:package_id => @package.id)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @package }
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Oops, something wrong in your request !"
      redirect_to dashboard_packages_path
    end
  end

  # GET /packages/new
  # GET /packages/new.json
  def new
    max = Role.find(current_user.roles.first.id).maximum_packages
    if current_user.packages.count+1 > max
      redirect_to dashboard_packages_path, :notice => "Your subscription allowed only #{max} packages !"
      return
    else
      @package = Package.new
      @recipient = Recipient.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @package }
      end
    end

  end

  # GET /packages/1/edit
  def edit
    @package = Package.find(params[:id])
    @recipient = Recipient.new
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = current_user.packages.new
    @recipient = Recipient.new
    @package.name = params[:package][:name]
    @package.description = params[:package][:description]

    if current_user.has_role? :large
      @package.key = params[:package][:key]
      @package.custom_key = params[:package][:custom_key]
    else
      @package.custom_key = false
      @package.create_aes_key
    end

    @recipients = Recipient.where(:user_id => current_user.id)

    if params[:recipient][:using_exist_address] == "true"
      @package.recipient_id = params[:recipient_id]
    else # new address
         # Recipient
      @recipient.name = params[:recipient][:name]
      @recipient.email = params[:recipient][:email]
      @recipient.user_id = current_user.id
      @recipient.address = params[:recipient][:address]
      @recipient.phone_number = params[:recipient][:phone_number]
      if @recipient.save
        @package.recipient_id = @recipient.id
      else
        flash[:error] = "Recipient's infor is not valid, create package failed !"
        render action: "new"
        return
      end
    end
    if @package.save
      flash[:notice] = "Package created successfuly !"
      redirect_to dashboard_packages_path
      return
    else
      flash[:error] = "Package's infor is not valid !"
      render action: "new"
      return
    end
  end

  # PUT /packages/1
  # PUT /packages/1.json
  def update
    @package = Package.find(params[:id])
    respond_to do |format|
      if @package.update_attributes(params[:package])
        format.html { redirect_to @package, notice: ' Package was successfully updated. ' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package = Package.find(params[:id])
    @package.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_packages_path }
      format.json { head :no_content }
    end
  end

  def viewrecipient
    begin
      @recipient = Recipient.find(params[:id])
      if @recipient.user_id != current_user.id # user can't view another user' recipient
        redirect_to dashboard_packages_path
      end
    end
  rescue StandardError
    redirect_to dashboard_packages_path

  end

  private
  def get_addresses
    @recipients = Recipient.where(:user_id => current_user.id)
  end
end
