class Manifest < ApplicationRecord
  has_many :manifest_tag_relations
  has_many :tags, through: :manifest_tag_relations
  belongs_to :user
  has_many :manifest_comments
end
