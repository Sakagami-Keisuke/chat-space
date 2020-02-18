# 自動更新⑶追加したアクションを動かすためのルーティングを実装
json.array! @messages do |message|
  json.content     message.content
  json.image       message.image
  json.date        message.created_at
  json.user_name   message.user.name
  json.id          message.id
end


# json形式でレスポンスするためのファイルを作成しよう
# ① viewsフォルダに「api」フォルダを作成しましょう
# ② apiフォルダに「messages」フォルダを作成しましょう
# ③messagesフォルダ内に「index.json.jbuilder」を作成しましょう
# ④index.json.jbuilderファイルを編集しましょう。
# メッセージは複数投稿されている可能性があるため、配列形式でarray!メソッドを使用してJSONを作成します。