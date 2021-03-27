class ManifestTag
  include ActiveModel::Model
  attr_accessor :title, :description, :name, :user_id

  with_options presence: true do
    validates :title
    validates :description
    validates :name
    validates :user_id
  end

  def save
    manifest = Manifest.create(title: title, description: description, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ManifestTagRelation.create(manifest_id: manifest.id, tag_id: tag.id)
  end
end
