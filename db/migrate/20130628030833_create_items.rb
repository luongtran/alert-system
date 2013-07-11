class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :package_id
      t.string :name
      t.string :description
      t.integer :item_type
      t.text :text_content
      t.string :file_name
      t.string :file_content_type
      t.text :s3_url
      t.timestamps
    end
  end
end
