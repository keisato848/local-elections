class ManifestTag
  include ActiveModel::Model
  attr_accessor :title, :description, :name

  with_options presence: true do
    validates :title
    validates :description
    validates :name
  end

  def save
    manifest = Manifest.create(title: title, description: description)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ManifestTagRelation.create(manifest_id: manifest.id, tag_id: tag.id)
  end
end
