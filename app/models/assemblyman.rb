class Assemblyman < ApplicationRecord
  belongs_to :council
  has_many :comments, dependent: :destroy
end
