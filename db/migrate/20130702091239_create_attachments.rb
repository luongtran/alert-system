class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :filename
      t.string :content_type
      t.binary :data

      t.timestamps
    end
  end
end
