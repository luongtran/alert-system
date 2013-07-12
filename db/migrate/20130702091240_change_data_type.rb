class ChangeDataTypes < ActiveRecord::Migration
  def change
    change_column :recipients , :phone_number,:string
  end
end
