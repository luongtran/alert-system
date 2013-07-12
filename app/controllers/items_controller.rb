class ItemsController < ApplicationController
  include ItemsHelper
  before_filter :authenticate_user!
  before_filter :find_package
  respond_to :js, :html


  # GET /items/1
  # GET /items/1.json
  def download
    @item = Item.find(params[:id])
    if @item.item_type != 1
      if !@package.custom_key
        aes_key = Base64.decode64(@package.encrypted_key)
        data = s3_downloader("#{ENV['s3_bucket_prefix']}#{@item[:package_id]}", @item.file_name, aes_key)
      else
        data = s3_downloader("#{ENV['s3_bucket_prefix']}#{@item[:package_id]}", @item.file_name)
      end
      if data.nil?
        flash[:notice] = "An error has occurred, please try again later !"
      else
        send_data(data, :filename => @item.file_name, :type => @item.file_content_type)
      end


    end
    #redirect_to
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    puts "\n\n__________Update"
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @item = Item.find(params[:id])
    if @package.custom_key
      if @item.item_type == 1
        temp = Base64.decode64(@item.text_content)
        @text_content_encrypted = temp
      else
      end
    else # key stored in db
      if @item.item_type == 1
        temp = Base64.decode64(@item.text_content)
        key = Base64.decode64(@package.encrypted_key)
        @text_content_encrypted = temp
        @text_content_decrypted = text_AES_Decryptor(temp, key)
      else
        # show file name
      end
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    # @packages = current_user.packages.where(:custom_key == false)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = @package.items.new
    # bad code !!
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
      redirect_to package_path(@package)
    else
      i = 0
      @item.errors.full_messages.each do |message|
        flash["error#{i}"] = message
        i+=1
      end
      render action: :new
    end
    # respond_with @package
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    if @package.items.count == 0
      if @package.custom_key == true
        Package.find(@package.id).destroy

        flash[:notice] = "Package deleted !"
        redirect_to dashboard_packages_path
        return
      end
    end
    redirect_to @package
    #respond_to do |format|
    #  format.html { redirect_to items_url }
    #  format.json { head :no_content }
    #end
  end

  private

  def find_package
    begin
      @package = Package.find(params[:package_id])
    end
  rescue StandardError => e
    flash[:notice] = "Oops, something wrong in your request !"
    redirect_to dashboard_packages_path
  end

end
