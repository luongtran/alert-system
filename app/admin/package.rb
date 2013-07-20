ActiveAdmin.register Package do
  #  actions :all, :except => [:destroy, :edit, :update, :create]
  actions :show, :index
  index do
    column :id
    column :user_id
    column :name
    column :description
    column :custom_key
    column :encrypted_key
    column :created_at
    column :send_to_recipient_at
    default_actions
  end
 
end