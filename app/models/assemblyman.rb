class Assemblyman < ApplicationRecord
  belongs_to :council
  belongs_to :user
  has_one :comments, dependent: :destroy

  validates :name, presence: true
  with_options allow_blank: true do
    validates :sex, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'は全角文字で入してください' }
    validates :birth_of_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }
    validates :number_of_wins, numericality: :only_integer
    validates :twitter_url, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'は半角アルファベット（大文字・小文字）、数値で入力してください' }
    validates :img_url, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, message: 'は無効な値です' }
  end
end
