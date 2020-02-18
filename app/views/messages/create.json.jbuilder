json.content    @message.content
json.image      @message.image.url
json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.user_name  @message.user.name
#idもデータとして渡す
json.id @message.id


# jbuilderを使用して、作成したメッセージをJSON形式で返す

# messageフォーム入力送信した時、ターミナル確認
# Started POST "/groups/7/messages" for ::1 at 2020-02-18 12:57:37 +0900
# Processing by MessagesController#create as JSON
#   Parameters: {"utf8"=>"✓", "authenticity_token"=>"6aS+Qf9Bapyex3DgR2k269h2sNZpV+kUYKcH1Z71+fV7/YnDitedT/H9W/ZmM0O1IoRV7xqih+ONhQETrjtPVw==", "message"=>{"content"=>"どうでしょう"}, "group_id"=>"7"}
#   User Load (0.3ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 4 ORDER BY `users`.`id` ASC LIMIT 1
#   Group Load (0.3ms)  SELECT  `groups`.* FROM `groups` WHERE `groups`.`id` = 7 LIMIT 1
#    (0.1ms)  BEGIN
#   User Load (0.4ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 4 LIMIT 1
#   SQL (0.3ms)  INSERT INTO `messages` (`content`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES ('どうでしょう', 7, 4, '2020-02-18 03:57:37', '2020-02-18 03:57:37')
#    (0.9ms)  COMMIT
#   Rendering messages/create.json.jbuilder
#   Rendered messages/create.json.jbuilder (0.6ms)
# Completed 200 OK in 34ms (Views: 20.4ms | ActiveRecord: 2.4ms)





# binding.pry実行 フォームに”坊ちゃんだからだよ”入力送信した時、ターミナルでparams確認
# Started POST "/groups/7/messages" for ::1 at 2020-02-18 13:04:40 +0900
# Processing by MessagesController#create as JSON
#   Parameters: {"utf8"=>"✓", "authenticity_token"=>"34765P8iYyWwkN3sV/bwlal/AlXiDy0t3aalvO5cpTlN181mirSU9t+q9vp2rIXLU43nbJH6Q9owhKN63pITmw==", "message"=>{"content"=>"坊ちゃんだからだよ"}, "group_id"=>"7"}
#   User Load (0.4ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 4 ORDER BY `users`.`id` ASC LIMIT 1
#   Group Load (0.2ms)  SELECT  `groups`.* FROM `groups` WHERE `groups`.`id` = 7 LIMIT 1
#    (0.2ms)  BEGIN
#   User Load (0.4ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 4 LIMIT 1
#   SQL (0.3ms)  INSERT INTO `messages` (`content`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES ('坊ちゃんだからだよ', 7, 4, '2020-02-18 04:04:40', '2020-02-18 04:04:40')
#    (0.5ms)  COMMIT
#   Rendering messages/create.json.jbuilder

# From: /Users/user/projects/chat-space/app/views/messages/create.json.jbuilder @ line 7 ActionView::CompiledTemplates#_app_views_messages_create_json_jbuilder__4287636750625750173_70263467027340:

#      2: json.image      @message.image.url
#      3: json.created_at @message.created_at.strftime("%Y年%m月%d日 %H時%M分")
#      4: json.user_name  @message.user.name
#      5: #idもデータとして渡す
#      6: json.id @message.id
#  =>  7: binding.pry
#      8: 
#      9: # jbuilderを使用して、作成したメッセージをJSON形式で返す
#     10: 
#     11: # messageフォーム入力した時のターミナル確認
#     12: # Started POST "/groups/7/messages" for ::1 at 2020-02-18 12:57:37 +0900

# [1] pry(#<#<Class:0x00007fcef9b62248>>)> params
# => <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"34765P8iYyWwkN3sV/bwlal/AlXiDy0t3aalvO5cpTlN181mirSU9t+q9vp2rIXLU43nbJH6Q9owhKN63pITmw==",
#    "message"=><ActionController::Parameters {"content"=>"坊ちゃんだからだよ"} permitted: false>, "controller"=>"messages", "action"=>"create", "group_id"=>"7"} permitted: false>
# [2] pry(#<#<Class:0x00007fcef9b62248>>)> 
