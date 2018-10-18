Rails.application.routes.draw do
  get 'home/top'
  get 'home/main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#top"
end
