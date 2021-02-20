# テーブル設計

## users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|nickname|string|null:false|

### Association
- has_many :comments

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
|prefecture|string|null:false|
|council_name|string|null:false|
|name|string|null:false|
|birth_of_date|date|null:false|
|faction|string|null:false|
|number_of_wins|integer|null:false|
|img_url|text|null:false|
|council|references|null:false, foreign_key: true|

### Association
- belongs_to :council
- has_one :comments

## comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :assemblyman