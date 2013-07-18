AlertSystem::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post "dashboard/create_new_item"
  get "dashboard/new_item"
  get "dashboard/items"
  get "dashboard/packages"
  get "dashboard/index", :as => :dashboard
  get "dashboard/pricing"

  get "recipient/get/(:code)" => "recipient#get", :as => :verify
  # get "recipient/delete"
  get "recipient/download_item/(:code)" => "Recipient#download_item"
  get "check_in/welcomeback"

  get "home/pricing"
  get "recurly/test"
  post "recurly/push"
  post "users/update_billing"

  get "users/edit_billing"

  match "pricing" => "home#pricing"
  match "recipient/delete/(:code)" => "recipient#delete"
  match 'packages/:package_id/items/:id/download' => 'items#download', :as => :download_item


  get 'packages/viewrecipient'
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => 'registrations'}
  ActiveAdmin.routes(self)
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
  end

  resources :attachments
  resources :users

  resources :packages do
    resources :items
  end

  get "/packages/check-custom-key/(:id)" => "packages#check_package_custom_key"

  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => {:confirmations => "confirmations"}
  ActiveAdmin.routes(self)
end