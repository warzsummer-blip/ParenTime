Rails.application.routes.draw do
  devise_for :users
  root "events#index"

  resources :events, only: [:index, :show, :new, :create] do
    member do
      patch :confirm_attendee
      post :auto_schedule   # 自動割り当てを実行
      post :reset_schedule  # 割り当てリセット
    end
  end

  namespace :public do
    resources :events, param: :token, only: [:show] do
      member do
        post :respond
      end
    end
  end
end