Rails.application.routes.draw do
  resources :tasks
  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api do
    resources :tasks
  end
end
