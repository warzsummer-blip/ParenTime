Rails.application.routes.draw do
  devise_for :users
  # ヘルスチェック用（Railsデフォルト）
  get "up" => "rails/health#show", as: :rails_health_check

  # ここに今後ルーティングを追加していきます
end