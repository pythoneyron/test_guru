Rails.application.routes.draw do

  get '/questions', to: 'questions#show_all'

  resources :tests do
    resources :questions, shallow: true
  end

end