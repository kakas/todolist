Rails.application.routes.draw do

  devise_for :users

  root "boards#index"

  resources :boards do
    get :change,            on: :member
    post :visible_all,      on: :member
    post :visible_active,   on: :member
    post :visible_complete, on: :member

    resources :lists do
      post :done_toggle, on: :member
    end
  end

end
