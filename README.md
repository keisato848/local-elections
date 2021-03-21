# テーブル設計

## users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|nickname|string|null:false|

### Association
- has_many :comments, 
<!-- 議員情報編集者の管理 -->
- has_many :assemblymen

## prefecture table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|

### Association
- has_many :council

## council table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|prefecture|references|null:false, foreign_key: true|

### Association
- belongs_to :prefecture
- has_many :assemblymen

## assemblymen table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|sex|string||
|birth_of_date|date||
|position|string||
|faction|string||
|number_of_wins|integer||
|img_url|text||
|job|string||
|twitter_url|text||
|council|references|null:false, foreign_key: true|
|user|references||

### Association
- belongs_to :council
<!-- 議員情報編集者の管理 -->
- belongs_to :user
- has_one :comments, dependent: :destroy

## comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :assemblyman