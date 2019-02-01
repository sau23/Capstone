Rails.application.routes.draw do
  get 'survey/instructions'
  get 'survey/question'
  get 'survey/feedback'
  get 'admin/data'
  get 'login/login'
  get 'login/new_user'
  root 'login#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
