class Council < ApplicationRecord
  belongs_to :prefecture
  has_many :assemblymen
end
