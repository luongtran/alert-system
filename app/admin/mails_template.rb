ActiveAdmin.register MailTemplate do
  index do
    column :name
    column :subject
    column :body
    actions :defaults => false do |p|
      link_to "View", admin_mail_template_path(p)
    end
    actions :defaults => false do |p|
       link_to "Edit", edit_admin_mail_template_path(p)
    end

  end

  show do
    h2 "Name: #{mail_template.name}"
    h4 "Subject: #{mail_template.subject}"
    div do
      raw mail_template.body
    end
  end

  form do |f|
    f.inputs "Subject" do
      f.text_field :subject
    end
    f.inputs "Body" do
      f.input :body, :as => :ckeditor
    end
    f.actions
  end
end