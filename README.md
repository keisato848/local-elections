## アプリ名
Local Elections（ローカルエレクションズ）

## 概要
地方議会情報の参照と、マニュフェスト投稿ができるウェブアプリケーションです。

## 本番環境
### デプロイ先
http://local-elections.site
### テストアカウント
|アカウント名|email|password|
|-|-|-|
|test-user1|example1@example.com|testtest1|
|test-user2|example@example.com|testtest2|

## 制作意図
【背景】  
 地方議会への関心を高めるために制作しました。投票率は国政選挙と比較しても低水準であり、数百・千億円単位の予算が審議されているにも関わらず、民衆の関心が高いとは言えません。また、多くの人は、地元紙や地元テレビ局等の報道から、情報を取得しますが、若者の新聞・テレビ離れが進んでいます。  
【目的】  
若者の政治への関心を高めるため、ウェブ上で議員の情報を参照できるサイトを制作しました。また、地域について自由に発言・交流できる場として、マニュフェスト投稿機能を実装しました。実際の政治・行政に反映されることで、地域社会が発展すれば幸いです。

## DEMO
## トップページ
[![Image from Gyazo](https://i.gyazo.com/c123c60df4331f63d68e6bb6e72137c3.jpg)](https://gyazo.com/c123c60df4331f63d68e6bb6e72137c3)
## 新規登録
※SSL化未対応のため、フェイスブックでのユーザー認証は本番環境でエラーとなる場合があります
[![Image from Gyazo](https://i.gyazo.com/9ddb2bbf58b1ec7f7921f80d18289040.gif)](https://gyazo.com/9ddb2bbf58b1ec7f7921f80d18289040)
## 議員検索の一連動作
※GooglechromeではTwitterのタイムラインが正常に表示されない場合があります
[![Image from Gyazo](https://i.gyazo.com/9e70361aeca966279c11b3ee628bd599.gif)](https://gyazo.com/9e70361aeca966279c11b3ee628bd599)
## マニュフェスト投稿の一連動作
[![Image from Gyazo](https://i.gyazo.com/3df43ccb5d92ed8130c342a827b206c4.gif)](https://gyazo.com/3df43ccb5d92ed8130c342a827b206c4)
## コメント投稿機能
[![Image from Gyazo](https://i.gyazo.com/6c53bd3a4f505c099d047aa0d9dc70c6.gif)](https://gyazo.com/6c53bd3a4f505c099d047aa0d9dc70c6)

## 工夫点
- フォームオブジェクトの導入  
マニュフェスト投稿時に、manifestテーブルとtagテーブルの情報が更新されるように、formオブジェクトを導入しています。ユースケースを想定しながらupdate、destroyアクションを定義することで、期待通りの機能を実装することができました。
## 使用技術

### バックエンド
Ruby, Ruby on Rails
### フロントエンド
ERB, Sass, JavaScript, Ajax
### データベース
Mysql, Sequel pro
### Webサーバ（本番環境）
Nginx
### アプリケーションサーバ（本番環境）
unicorn
### ソース管理
Github, GithubDesktop
### テスト
Rspec
### エディタ
VScode

## DB設計
### users table
|Column|Types|Options|
|-|-|-|
|email|string|null:false, unique: true|
|nickname|string|null:false|

#### Association
- has_many :assemblymen
- has_one :comments, dependent: :destroy
- has_one :manifests, dependent: :destroy

### sns_credentials
|Column|Types|Options|
|-|-|-|
|provider|string|-|
|uid|string|-|
|user|references|foreign_key: true|

#### Association
- belongs_to :user, optional: true

### prefecture table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|

#### Association
- has_many :council

### council table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|prefecture|references|null:false, foreign_key: true|
|election_day|date||

#### Association
- belongs_to :prefecture
- has_many :assemblymen

### assemblymen table
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

#### Association
- belongs_to :council
- belongs_to :user, optional: true
- has_one :comments, dependent: :destroy

### manifest table
|Column|Types|Options|
|-|-|-|
|title|string|null:false|
|description|text|null:false|
|user|references|null:false, foreign_key:true|

#### Association
- belongs_to :user
- has_many :manifest_tag_relations
- has_many :tags, through: :manifest_tag_relations

### tags table
|Column|Types|Options|
|-|-|
|name|string|null:false, uniqueness: true|

#### Association
- has_many :manifest_tag_relations
- has_many :manifests, through: :manifest_tag_relations

### manifest_tag_relations table
|Column|Types|Options|
|-|-|
|manifest|references|foreign_key: true|
|tag|references|foreign_key: true|

#### Association
- belongs_to :manifest
- belongs_to :tag 

### comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :assemblyman
