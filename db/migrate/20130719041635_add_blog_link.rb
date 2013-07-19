class AddBlogLink < ActiveRecord::Migration
  def up
    add_column :home_page_contents, :blog_link, :text
  end

  def down
  end
end
