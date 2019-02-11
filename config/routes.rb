Rails.application.routes.draw do
  get 'questions/survey'
  get 'users/login'
  root 'users#login'
  resources :feedbacks
  resources :questions
  resources :responses
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
