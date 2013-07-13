class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @packages_count = current_user.packages.count
    @items_count = current_user.items.count
    @next_validate_at = DateTime.now + current_user.frequency.days
  end

  def pricing
    @current_user_role_id = current_user.roles.first.id
    @current_user_role_name =  current_user.roles.first.name
  end

  def packages
    @packages = current_user.packages
  end

  def items
    @items = current_user.items
    @text_item_count = @items.where(:item_type => 1).count
    @file_item_count = @items.where(:item_type => 2).count
    @image_item_count = @items.where(:item_type => 3).count
  end

  def setting

  end
end
