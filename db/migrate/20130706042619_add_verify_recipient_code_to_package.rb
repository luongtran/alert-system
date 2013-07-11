class AddVerifyRecipientCodeToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :verify_recipient_code, :string
  end
end
