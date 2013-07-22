# :email, :name, :address, :phone_number, :user_id
ActiveAdmin.register Recipient do
  index do
    column :id
    column :name
    column :email
    column :address
    column :phone_number
    default_actions
  end
end