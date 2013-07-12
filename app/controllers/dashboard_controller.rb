class DashboardController < ApplicationController
  before_filter :authenticate_user!

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
