Chat-space DB設計　マークダウン

# chat-space DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many  :messages,  through:  :users_messages
- has_many :users_groups

## messageテーブル
|Column|Type|Options|
|------|----|-------|
|message_id|integer|null: false
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
|user_group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :user_group
- belongs_to :group

## groupテーブル
|Column|Type|Options|
|------|----|-------|
|group_id|integer|null: false
|group_name|text|null: false|
### Association
- has_many :messages
- has_many  :messages,  through:  :users_messages

## users_groupsテーブル
|Column|Type|Options|
|------|----|-------|
|user_group_id|integer|null: false
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :group
- belongs_to :user_group

