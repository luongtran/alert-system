class AddRecipientIdToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :recipient_id, :integer
  end
end
