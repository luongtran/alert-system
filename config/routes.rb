AlertSystem::Application.routes.draw do
  get "dashboard/index"
  get "dashboard/items"
  get "dashboard/packages"
  
  get "recipient/get"
  get "recipient/delete"
  get "check_in/welcomeback"
  #get 'items/download'
  get "home/pricing"
  get "recurly/test"
  post "recurly/push"
  
  match "pricing" => "home#pricing"
  
  match "dashboard" => "dashboard#index"
  
  
  match 'packages/:package_id/items/:id/download' => 'items#download', :as => :download_item


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => 'registrations'}
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
  end
  resources :attachments
  resources :users
  
  resources :packages do
    resources :items
  end
  as :user do
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => {:confirmations => "confirmations"}
end