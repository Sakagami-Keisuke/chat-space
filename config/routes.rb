Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :users, only: [:index, :edit, :update]       # indexはインクリメンタルサーチ実装
  resources :groups, only: [:index, :new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]

    #自動更新 ⑶追加したアクションを動かすためのルーティングを実装
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end          #defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定。
  end
end


# rake routes
# Prefix               Verb    URI Pattern                               Controller#Action
# group_api_messages   GET    /groups/:group_id/api/messages(.:format)   api/messages#index {:format=>"json"}



# resources :users, only: [:index  インクリメンタルサーチのルーティング
#  user_controllerを編集しapiを生成  index.json.jbuilderを作成し、json形式で値を返せるように実装


# namespace :ディレクトリ名 do ~ endと囲む形でルーティングを記述すると、そのディレクトリ内のコントローラのアクションを指定
#   ターミナルからrails routesコマンドなどでルーティングを確認すると、/groups/:id/api/messagesというパスでリクエストを
#   受け付け、api/messages_controller.rbのindexアクションが動くようになっている
#   また、defaultsオプションを利用して、このルーティングが来たらjson形式でレスポンスするよう指定