ActiveAdmin.register Package do
  index do
    column :id
    column :user_id
    column :name
    column :description
    column :custom_key
    column :encrypted_key
    column :created_at
    default_actions
  end
end