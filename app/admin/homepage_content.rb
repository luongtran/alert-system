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
    column :halfpage_content
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
end