ActiveAdmin.register HomePageContent do
  index do
    column :id
    column :name
    column :title
    column :notepad_notetext
    column :introduce_lead
    column :introduce_inf_1
    column :introduce_inf_2
    column :introduce_inf_3
    column :signupquick_lead
    column :notice
    column :halfpage_lead
    column :pagefoot_inforunit1_head
    column :pagefoot_inforunit1_content
    column :pagefoot_inforunit2_head
    column :pagefoot_inforunit2_content
    column :pagefoot_inforunit3_head
    column :pagefoot_inforunit3_content
    column :pagefoot_inforunit4_head
    column :pagefoot_inforunit4_content
    column :active

    default_actions
  end
  form do |f|
    f.inputs "Name" do
      f.text_field :name
    end
    f.inputs "Title" do
      f.input :title
    end
    f.inputs "Notepad NoteText" do
      f.input :notepad_notetext, :as => :ckeditor
    end
    f.actions
  end
end
