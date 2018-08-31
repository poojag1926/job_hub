Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount FullCountrySelect::Engine => '/full_country_select'
  root 'homes#index'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies
  resources :jobs do
  	member do
  		put :update_status
      get :job_applied
  	end
  end
  resources :users
end
