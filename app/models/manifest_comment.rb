class ManifestComment < ApplicationRecord
  belongs_to :user
  belongs_to :manifest

  with_options presence: true do
    validates :user_id
    validates :manifest_id
    validates :content, length: { minimum: 3, maximum: 256 }
  end
end
