Rails.application.routes.draw do

  root to: "home#index"

  resources :tests do
    resources :questions, shallow: true
  end

end
