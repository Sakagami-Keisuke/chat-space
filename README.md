# chat-space DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false
|email|string|null: false, unipue: true|
|password|string|null: false|
|name|string|null: false, unique: true|
### Association
- has_many  :messages,  through:  :groups_users
- has_many :groups_users

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|message_id|integer|null: false
|body|text|null: false|
|image|string|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
|groups_users_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|integer|null: false
|group_name|text|null: false|
### Association
- belongs_to :user
- has_many  :messages,  through:  :groups_users

## groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_group_id|integer|null: false
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group