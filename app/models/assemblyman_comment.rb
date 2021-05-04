class AssemblymanComment < ApplicationRecord
  belongs_to :user
  belongs_to :assemblyman

  with_options presence: true do
    validates :user_id
    validates :assemblyman_id
    validates :content, length: { minimum: 3, maximum: 256 }
  end
end
