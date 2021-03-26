# テーブル設計

## users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|nickname|string|null:false|

### Association
- has_many :comments
- has_many :assemblymen
- has_many :manifests, dependent: :destroy

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
|user|references|foreign_key: true|

### Association
- belongs_to :council
- belongs_to :user, optional: true
- has_one :comments, dependent: :destroy

## manifest table
|Column|Types|Options|
|-|-|-|
|title|string|null:false|
|description|text|null:false|
|user|references|null:false, foreign_key:true|

### Association
- belongs_to :user
- has_many :manifest_tag_relations
- has_many :tags, through: :manifest_tag_relations

## tags table
|Column|Types|Options|
|-|-|
|name|string|null:false, uniqueness: true|

### Association
- has_many :manifest_tag_relations
- has_many :manifests, through: :manifest_tag_relations

## manifest_tag_relations table
|Column|Types|Options|
|-|-|
|manifest|references|foreign_key: true|
|tag|references|foreign_key: true|

### Association
- belongs_to :manifest
- belongs_to :tag 

## comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :assemblyman