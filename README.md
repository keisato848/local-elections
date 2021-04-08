## アプリ名
Local Elections（ローカルエレクションズ）

## 概要
地方議会情報の参照とユーザーが考案したマニュフェストを投稿できるウェブアプリケーションです。

## 本番環境
### デプロイ先
http://local-elections.site
### テストアカウント
|アカウント名|email|password|
|-|-|-|
|test-user1|example1@example.com|testtest1|
|test-user2|example@example.com|testtest2|

## 制作意図
 自治体職員として働いた経験から、地方議会への関心を高めるために制作しました。地方議会は民衆の関心が低い一方、数百・千億円単位の予算が審議されていますが、投票率は国政選挙と比較しても低水準です。
 多くの人は、地元紙や地元テレビ局等の報道から、地方議会の情報を取得しますが、若者の新聞・テレビ離れが進むなか 、ウェブ上で議員の情報を参照できるサイトが必要であり、若者の政治参加の一助になるのではと考え、制作しました。
  また、マニュフェスト投稿機能については、一般の方にも地域について自由に発言・交流してほしいとの思いから実装しました。好評なマニュフェストが実際の政治に反映されたり、地元を離れた選挙区外の住民が投稿したりすることで、地域社会のますますの発展を望んでいます。

## DEMO
リファクタリング後に撮影

## 工夫点
- フロントのレスポンシブ対応
- エラーハンドリング
- フォームオブジェクトの導入

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

## 課題・今後実装したい機能
（課題）
- 個人利用範囲内であれば問題ないが、ウェブアプリケーションとして一般公開するためには、自治体に議員写真の使用許可をもらう、または写真を非表示にする必要がある。
（実装したい機能）
- マニュフェストに対して、非同期通信でリアクションできる機能
- 投票期日をGoogleカレンダーAPIを利用して管理する機能

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