ActiveAdmin.register MailTemplate do
  index do
    column :name
    column :subject
    column :body
  end
  show do
    h2 "Name: #{mail_template.name}"
    h3 "Subject: #{mail_template.subject}"
    div do
      raw mail_template.body
    end
  end
  form do |f|
    f.inputs "Select Type" do
      f.select :name, MailTemplate::NAMES.collect { |s| [s.titleize] }, {:prompt => "  Select an email to edit  "}
    end
    f.inputs "Subject" do
      f.text_field :subject
    end
    f.inputs "Body" do
      f.input :body, :as => :ckeditor
    end
    f.actions
  end
end