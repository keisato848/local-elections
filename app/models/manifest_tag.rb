class ManifestTag
  include ActiveModel::Model
  attr_accessor :title, :discription, :name

  with_options presence: true do
    validates :title
    validates :discription
    validates :name
  end

  def save
    manifest = Manifest.create(title: title, discription: discription)
    tag = Tag.create(name: name)

    ManifestTagRelation.create(manifest_id: manifest.id, tag_id: tag.id)
  end
end
