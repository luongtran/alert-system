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
    column :share_link
    column :blog_link
    default_actions
  end
  filter :name
  filter :active
  form do |f|
    f.inputs "Name" do
      f.text_field :name
    end
    f.inputs "Home page title" do
      f.text_field :title
    end
    f.inputs "Notepad NoteText" do
      f.input :notepad_notetext, :as => :ckeditor
    end
    f.inputs "Introduce headline" do
      f.text_field :introduce_lead
    end
    f.inputs "Introduce infor 1" do
      f.text_field :introduce_inf_1
    end
    f.inputs "Introduce infor 2" do
      f.text_field :introduce_inf_2
    end
    f.inputs "Introduce infor 3" do
      f.text_field :introduce_inf_3
    end
    f.inputs "Signup quick headline" do
      f.text_field :signupquick_lead
    end
    f.inputs "Notice text(in signup quick area)" do
      f.input :notice, :as => :ckeditor
    end

    f.inputs "Halfpage headline" do
      f.text_field :halfpage_lead
    end
    f.inputs "Halfpage content" do
      f.input :halfpage_content, :as => :ckeditor
    end
    f.inputs "Tip Unit 1 headline" do
      f.text_field :pagefoot_inforunit1_head
    end
    f.inputs "Tip Unit 1 content" do
      f.input :pagefoot_inforunit1_content, :as => :ckeditor
    end
    f.inputs "Tip Unit 2 headline" do
      f.text_field :pagefoot_inforunit2_head
    end
    f.inputs "Tip Unit 2 content" do
      f.input :pagefoot_inforunit2_content, :as => :ckeditor
    end

    f.inputs "Tip Unit 3 headline" do
      f.text_field :pagefoot_inforunit3_head
    end
    f.inputs "Tip Unit 3 content" do
      f.input :pagefoot_inforunit3_content, :as => :ckeditor
    end

    f.inputs "Tip Unit 4 headline" do
      f.text_field :pagefoot_inforunit4_head
    end
    f.inputs "Tip Unit 4 content" do
      f.input :pagefoot_inforunit4_content, :as => :ckeditor
    end
    f.inputs "Active this config ?" do
      f.input :active
    end
    f.inputs "Google, Tweet share link" do
      f.text_field :share_link
    end
    f.inputs "Blog link" do
      f.text_field :blog_link
    end
    f.actions
  end
end

