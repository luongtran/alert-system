class AddSomeColsToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :send_to_recipient_at, :datetime
  end
end
