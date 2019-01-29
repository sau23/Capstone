Rails.application.routes.draw do
  get 'login/homepage'
  root 'login#homepage'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
