class CreateHomePageContents < ActiveRecord::Migration
  def change
    create_table :home_page_contents do |t|
      t.string :name
      t.string :title
      t.text :notepad_notetext
      t.string :introduce_lead
      t.text :introduce_inf_1
      t.text :introduce_inf_2
      t.text :introduce_inf_3
      t.string :signupquick_lead
      t.text :notice
      t.string :halfpage_lead
      t.text :halfpage_content

      t.string :pagefoot_inforunit1_head
      t.text :pagefoot_inforunit1_content

      t.string :pagefoot_inforunit2_head
      t.text :pagefoot_inforunit2_content

      t.string :pagefoot_inforunit3_head
      t.text :pagefoot_inforunit3_content

      t.string :pagefoot_inforunit4_head
      t.text :pagefoot_inforunit4_content

      t.boolean :active, :default => false
    end
  end
end
