ActiveAdmin.register Package do
  #  actions :all, :except => [:destroy, :edit, :update, :create]
  actions :show, :index
  index do
    column :id
    column :user_id
    column :name
    column :description
    column "Items count" do |p|
      p.items.count
    end
    column :encrypted_key
    column :send_to_recipient_at
    column "Recipient Email" do |p|
      r= Recipient.find(p.recipient_id)
      "#{r.email}"
    end
    column :created_at
    default_actions
  end
  filter :name
end