Rails.application.routes.draw do
  get 'home/top'
  get 'home/main'
  post "home/top" => "home#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#top"

end
