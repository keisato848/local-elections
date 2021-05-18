class Assemblyman < ApplicationRecord
  belongs_to :council
  belongs_to :user, optional: true
  has_many :assemblyman_comments, dependent: :destroy

  validates :name, presence: true
  with_options allow_blank: true do
    validates :sex, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'は全角文字で入してください' }
    validates :birth_of_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
    validates :number_of_wins, numericality: :only_integer
    validates :twitter_url, format: { with: /\A[0-9a-zA-Z_]{1,15}\z/, message: 'は＠を含まずに15文字以内で入力してください（半角英数、アンダーバーのみ利用可）' }
    validates :img_url, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, message: 'は無効な値です' }
  end

  # 検索用フォームに表示する値を取得
  def self.setting_search(council_id)
    assemblymen = Assemblyman.where(council_id: council_id)
    factions = []
    assemblymen.each do |assemblyman|
      factions << assemblyman.faction
    end
    factions
  end

  # 検索条件が設定されているか判別
  def self.search_correct?(faction, sex)
    return true unless faction.empty? && sex.empty?
  end
end
