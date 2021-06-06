Rails.application.routes.draw do

  root to: "home#index"

  resources :tests do
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
  end

end
