class Election < ApplicationRecord
  has_many :councils
  with_options presence: true do
    validates :day
    validates :council_id
  end
end
