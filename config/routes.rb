Rails.application.routes.draw do

  devise_for :users

  root "boards#index"

  resources :boards do
    member do
      get :change
    end

    resources :lists do
      member do
        post :done_toggle
      end

      collection do
        get :visible_all
        get :visible_active
        get :visible_complete
      end
    end
  end

end
