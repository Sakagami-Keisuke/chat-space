Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :users, only: [:index, :edit, :update]       # indexはインクリメンタルサーチ実装
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
end


# resources :users, only: [:index  インクリメンタルサーチのルーティング
#  user_controllerを編集しapiを生成  index.json.jbuilderを作成し、json形式で値を返せるように実装