class Tag < ApplicationRecord
  has_many :manifest_tag_relations
  has_many :manifests, through: :manifest_tag_relations
  has_many :question_tag_relations
  has_many :questions, through: :question_tag_relations
  validates :name, uniqueness: true

  def self.find_tag(manifest)
    tags = Tag.find(manifest.tag_ids)
    tag_names = []
    tags.each do |tag|
      tag_names.append(tag.name)
    end
    tag_names
  end
end
