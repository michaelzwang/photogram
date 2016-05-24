Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }  
  resources :posts do
    resources :comments
  end

  root 'posts#index'
  get ':user_name', to: 'profiles#show', as: :profile 
end
