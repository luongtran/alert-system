class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @packages_count = current_user.packages.count
    @items_count = current_user.items.count
    @next_validate_at = DateTime.now + current_user.frequency.days
  end

  def pricing


  end

  def update_billing_infor
    account = Recurly::Account.find(current_user.customer_id)
    billing_infor = account.billing_info
    #account.billing_info = {
    #    :first_name => "#{self.first_name}-tenmoine",
    #    :last_name => self.last_name,
    #    :number => '4111-1111-1111-1111',
    #    :verification_value => '123',
    #    :month => 11,
    #    :year => 2015
    #}
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
