# 自動更新⑵メッセージを更新するためのアクションを実装
#APIの中にあると言う名前空間定義
class Api::MessagesController < ApplicationController

  def index

#今いるグループの情報をparamsの値を元にDBから取得し変数@groupに代入
    @group = Group.find(params[:group_id]) 

#グループが所有しているメッセージの中から、params[:last_id]よりも大きいidがないかMessageから検索して、@messagesに代入。
    @messages = @group.messages.includes(:user).where('id > ?', params[:last_id])
  end
end

# 名前空間(namespace)
# 名前空間をつけることにより、同様のクラス名で名付けたクラスを作ってもそれらを区別することができます。
# 今回の場合はcontrollers/messages_controller.rbとcontrollers/api/messages_controller.rbが存在しますが、ディレクトリを分けているおかげで区別できます。
# ただし、プログラムがクラスを判別する際はどのディレクトリに入っているかでの判別はできないため、名前空間を利用するルールになっています。
# こうすることで、Railsは間違えることなく2つのコントローラを区別するようプログラムされています。