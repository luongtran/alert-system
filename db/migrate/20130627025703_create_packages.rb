class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :user_id
      t.integer :recipient_id
      t.boolean :custom_key, :default => false
      t.string :encrypted_key
      t.string :verify_recipient_code
      t.string :description
      t.timestamps
    end
  end
end
