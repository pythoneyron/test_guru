Rails.application.routes.draw do

  root to: "home#index"

  devise_for :users, path: :gurus, path_names: {sign_in: :login, sign_out: :logout},
             controllers: { registrations: 'registrations', sessions: 'sessions' }

  resource :user_badges, only: %i[show]
  resource :badges, only: %i[show]

  resources :tests, only: :index do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :check_timer
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :gists, shallow: true, only: %i[show index]
    resources :badges, shallow: true
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end

  resources :feed_backs

end
