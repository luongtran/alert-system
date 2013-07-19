class AddShareLinkToTweetGoogle < ActiveRecord::Migration
  def change
    add_column :home_page_contents, :share_link, :text
  end
end
