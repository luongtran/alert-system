class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :phone_number
      t.integer :user_id
      t.timestamps
    end

  end
end
