class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_packages, :only => [:new_item, :create_new_item]

  def index
    @packages_count = current_user.packages.count
    @items_count = current_user.items.count
    @next_validate_at = DateTime.now + current_user.frequency.days
  end

  def pricing
    @current_user_role_id = current_user.roles.first.id
    @current_user_role_name = current_user.roles.first.name
  end

  def packages
    @packages = current_user.packages
  end

  def items
    @items = current_user.items
    @packages_count = current_user.packages.count
    @text_item_count = @items.where(:item_type => 1).count
    @file_item_count = @items.where(:item_type => 2).count
    @image_item_count = @items.where(:item_type => 3).count
  end

  def setting

  end

  def new_item
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def create_new_item

    @package = Package.find(params[:package_id])
    @item = @package.items.new


    @item.name = params[:item][:name]
    @item.description = params[:item][:description]
    if params[:type] == "text"
      @item.item_type = 1
      @item.text_content = params[:item][:text_content]
    else
      if params[:item][:file].nil?
        flash[:notice] = "Please select a file first!"
        redirect_to new_package_item_path
        return
      else
        if params[:type] == "file"
          @item.item_type = 2
        else
          @item.item_type = 3
        end
        @item.file = params[:item][:file]
        @item.filename = params[:item][:file].original_filename
        @item.file_content_type = params[:item][:file].content_type
      end
    end
    #______________________
    if @package.custom_key
      @item.aes_key = params[:item][:aes_key]
    else
      @item.aes_key = Base64.decode64(@package.encrypted_key)
    end
    if @item.save
      flash[:notice] = "Item was created successfuly !"
      redirect_to package_item_path(@package, @item)
    else
      i = 0
      @item.errors.full_messages.each do |message|
        flash["error#{i}"] = message
        i+=1
      end
      render action: :new_item
    end
  rescue ActiveRecord::RecordNotFound => e
    flash[:notice] = "Please select a package first !"
    redirect_to :back

  end


  private
  def get_packages
    @packages = current_user.packages
  end
end
