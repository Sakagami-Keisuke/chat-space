# ⑴ルーティングなどAPI側の準備をする
#＠ｕｓｅｒｓを配列形式にし、変数userとして分解していく
json.array! @users do |user|
  json.id user.id
  json.name user.name
end
#これにより、jsファイル上で、usersという配列、id、nameという変数が使えるようになる

# users_controllerでは respond_to メソッドを使用し、レスポンスをhtmlとjsonで条件分岐
# 今回はjsonがレスポンスとして返るので、jbuilderを生成しjsonを形成
# jbuilder:array! メソッド
# jbuilderという拡張子を持つテンプレートでは、JSONという名前のJbuilderオブジェクトが自動的に利用できる
# Jbuilderオブジェクトは、JSON形式に返すための便利なメソッドがたくさん用意されており、配列で返したい場合はarray!を使用
# array!を使用することで以下のように、JavaScript側に配列で値を送る
# JavaScript側に送る配列
# [{id: 1,image: "https://~.jpg",nickname: "やべ",text: "プログラミングの勉強中",user_id: 1,user_sign_in:{created_at: "2019-10-08T01:47:37.000Z",email: "aaa@gmail.com",id: 1,nickname: "やべ",updated_at: "2019-10-08T01:47:37.000Z"}}]
# 上記のように、jbuilderを使用するとより少ない記述でJSON形式のデータを作る