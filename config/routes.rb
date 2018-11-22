Rails.application.routes.draw do
  get 'home/message/:id' => "home#message"
  get 'home/message'
  get 'home/top'
  get 'home/main'
  post "home/main" => "home#create"
  post "home/message/:id" => "home#reply"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#top"
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

end
