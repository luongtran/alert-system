ActiveAdmin.register User do
  actions :show, :index, :delete
  index do
    column :id
    column "Full name" do |user|
      user.first_name+" "+user.last_name
    end
    column :email
    column "Role" do |u|
      "#{u.roles.first.name}"
    end
    column "Usage" do |user|
      "#{user.packages.count}  packages, #{user.items.count} items"
    end
    column :status
    column :last_sign_in_at
    column :sign_in_count
    default_actions

  end
  filter :roles
  filter :email
  filter :status
end