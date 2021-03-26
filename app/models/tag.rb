class Tag < ApplicationRecord
  has_many :manifest_tag_relations
  has_many :manifests, through: :manifest_tag_relations
end
