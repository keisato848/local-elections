[![CircleCI](https://circleci.com/gh/keisato848/local-elections.svg?style=shield&circle-token=361b0b3bf0560fc284f2f8c5485ad684da37ed1d)](https://circleci.com/gh/keisato848/local-elections)

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

## 制作意図
【背景】  
 地方議会への関心を高めるために制作しました。投票率は国政選挙と比較しても低水準であり、数百・千億円単位の予算が審議されているにも関わらず、国民の関心が高いとは言えません。また、多くの人は、地元紙や地元テレビ局等の報道から、情報を取得しますが、若者の新聞・テレビ離れが進んでいます。  
【目的】  
政治への関心を高めるため、ウェブ上で議員の情報を参照できるサイトを制作しました。また、地域について自由に発言・交流できる場として、マニュフェスト投稿機能を実装しました。議論が活発化し、地域社会が発展させたいと考えています。

## DEMO
## トップページ
※議員情報は富山県のデータのみ閲覧可能です。
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
- フロントエンドのデザイン・レイアウト
アプリケーションのUIはユーザーが直接接する部分であるため、サービスにおける印象を大きく左右します。そのため、PCでもスマートフォンでも操作しやすいように、レスポンシブなデザインを採用しています。

## アプリケーションの課題
- 議員情報の不足
議員情報は管理者のみ、登録することができ、ユーザーは編集することしかできません。全国の情報を管理者が登録するには労力がかかるため、①アプリケーションの縮小（富山版、中部版など）または、②ユーザーによる議員情報の登録が必要だと考えております。

## 今後、実装したい機能
- 管理者画面の導入  
ユーザー・議員情報の管理を効率化するため。
- 質問投稿機能  
自治体の予算案等でわからない点をユーザー同士で解決するため。
- マニュフェスト投稿機能へのマークダウン導入
マークダウンを導入することで、マニュフェストの可読性を向上させるため。
※Vue.jsのパッケージである、「vue-md-editor」を活用し、実装予定。
- Googleアナリティクスの設定
ユーザーの行動を分析し、今後のサイト制作に活用するため。

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
- has_many :sns_credentials
- has_many :assemblyman_comments, dependent: :destroy
- has_many :manifests, dependent: :destroy
- has_many :manifest_comments, dependent: :destroy
- has_many :questions
- has_many :question_comments

### sns_credentials table
|Column|Types|Options|
|-|-|-|
|provider|string|-|
|uid|string|-|
|user|references|foreign_key: true|

#### Association
- belongs_to :user, optional: true

### councils table
|Column|Types|Options|
|-|-|-|
|name|string|null:false|
|prefecture|integer|null:false|

#### Association
- belongs_to_active_hash :prefecture
- has_many :assemblymen
- has_many :election

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
- has_many :assemblyman_comments, dependent: :destroy

### manifests table
|Column|Types|Options|
|-|-|-|
|title|string|null:false|
|description|text|null:false|
|user|references|null:false, foreign_key:true|

#### Association
- has_many :manifest_tag_relations
- has_many :tags, through: :manifest_tag_relations
- belongs_to :user
- has_many :manifest_comments, dependent: :destroy

### question table
|Column|Types|Options|
|-|-|-|
|title|string|null:false|
|description|text|null:false|
|user|references|null:false, foreign_key:true|

#### Association
- has_many :question_tag_relations
- has_many :tags, through: :question_tag_relations
- belongs_to :user
- has_many :question_comments, dependent: :destroy

### tags table
|Column|Types|Options|
|-|-|-|
|name|string|null:false, uniqueness: true|

#### Association
- has_many :manifest_tag_relations
- has_many :manifests, through: :manifest_tag_relations
- has_many :question_tag_relations
- has_many :questions, through: :question_tag_relations

### manifest_tag_relations table
|Column|Types|Options|
|-|-|-|
|manifest|references|foreign_key: true|
|tag|references|foreign_key: true|

#### Association
- belongs_to :manifest
- belongs_to :tag 

### question_tag_relations table
|Column|Types|Options|
|-|-|-|
|question|references|foreign_key: true|
|tag|references|foreign_key: true|

#### Association
- belongs_to :question
- belongs_to :tag 

### assemblyman_comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|assemblyman|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :assemblyman

### manifest_comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|manifest|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :manifest

### question_comments table
|Column|Types|Options|
|-|-|-|
|comment|text|null:false|
|user|references|foreign_key: true|
|question|references|foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :question

### elections table
|Column|Types|Options|
|-|-|-|
|day|date|null:false|
|council|references|null: false, foreign_key: true|

#### Association
- has_many :councils
