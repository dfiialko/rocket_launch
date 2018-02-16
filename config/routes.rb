Rails.application.routes.draw do
  resources :rockets
  resources :agencies
  resources :pads
  resources :missions
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
