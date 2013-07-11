class AddAddressPhoneToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :address, :string
    add_column :recipients, :phone_number, :integer   
  end
end
