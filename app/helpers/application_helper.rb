module ApplicationHelper
  def default_meta_tags
    {
      site: 'Local Elections', # サイト名
      title: '地方議会ナビ', # タイトル
      reverse: false, # サイト名とタイトルを反転させるか
      separator: '|', # サイト名とタイトル区切り文字
      description: 'Local Electionsは地方議会に関する悩みを解決するサービスです。', # サイトの説明
      # キーワードの設定
      keywords: %w[
        議会
        地方
        議員
      ],
      canonical: request.original_url, # サイト内で評価される正規URLを検索エンジンに伝える
      noindex: !Rails.env.production?, # ページをGoogle検索に表示するかどうか
      # ファビコンの設定
      icon: [
        { href: image_url('favicon.ico') }
      ]
    }
  end
end
