Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'
  get 'events/new'
  get 'events/create'
  devise_for :users

  # ログイン後のトップページを行事一覧にする
  root "events#index"

  # 教員用の行事管理（一覧・詳細・新規作成）
  resources :events, only: [:index, :show, :new, :create]
end