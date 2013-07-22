module DashboardHelper

  def text_item_count(items)
   items.where(:item_type => 1).count
  end

  def file_item_count(items)
    items.where(:item_type => 2).count
  end

  def image_item_count(items)
    items.where(:item_type => 3).count
  end

end
