class ManifestTag
  include ActiveModel::Model
  attr_accessor :title, :description, :name, :user_id

  with_options presence: true do
    validates :title, uniqueness: true
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

  def update(manifest_id)
    manifest = Manifest.find(manifest_id)
    manifest.update(title: title, description: description)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    manifest_tag = ManifestTagRelation.find_by(manifest_id: manifest_id)
    manifest_tag.update(tag_id: tag.id)
  end

  def destroy(manifest_id)
    manifest_tag = ManifestTagRelation.find_by(manifest_id: manifest_id)
    manifest_tag.destroy
    manifest = Manifest.find(manifest_id)
    manifest.destroy
  end
end
