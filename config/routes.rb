Rails.application.routes.draw do
  devise_for :users

  resources :lists do
    member do
      post :done_toggle
    end
  end

end
