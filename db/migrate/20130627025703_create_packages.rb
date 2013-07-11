class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.boolean :custom_key, :default => false
      t.string :encrypted_key
      t.timestamps
    end
  end
end
