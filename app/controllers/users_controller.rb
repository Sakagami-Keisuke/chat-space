class UsersController < ApplicationController


  def index                                 # ⑴ルーティングなどAPI側の準備をする #検索した条件に当てはまるユーザーを@usersに代入
    return nil if params[:keyword] == ""     #キーワードがなければnilを返す # params[:keyword]に値が入っていればそのまま処理は続けられ、空だった場合はそこで処理が終わります。
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)     #その文字を含むユーザーを探してきて、@usersに代入、ただしログインしている自分は除く。10人まで。
    respond_to do |format|                   # respond_toメソッドは、リクエストで指定されたフォーマット（HTML,JSON,XML）に合わせて結果を返すメソッド
      format.html
      format.json                            # リクエストが.json形式できた場合は、json形式で値を返す記述
    end                                       # jsonがレスポンスとして返るので、jbuilderを生成しjsonを形成できる
  end

 
  # JSONとはJavaScript Object Notationの略で、XMLなどと同様のテキストベースのデータフォーマットです。
  # その名前の由来の通りJSONはJavaScriptのオブジェクト表記構文のサブセットとなっており、XMLと比べると簡潔に構造化されたデータを記述することができるため、記述が容易で人間が理解しやすいデータフォーマット
  # user_controllerを編集しapiを生成  index.json.jbuilderを作成し、json形式で値を返せるように実装
  # # users_controllerでは respond_to メソッドを使用し、レスポンスをhtmlとjsonで条件分岐させます。
  # params[:keyword]に値が入っていればそのまま処理は続けられ、空だった場合はそこで処理が終わります。
  # 検索処理の内容は、whereメソッドを使用し、入力された値を含むかつ、ログインしているユーザーのidは除外するという条件で取得
    # whereメソッド
  # 任意のデータベースから任意の条件を指定し、条件に当てはまるレコードを すべて 取得する


  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end