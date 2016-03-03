Rails.application.routes.draw do
  devise_for :users

  resources :boards

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
