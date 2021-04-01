class CreateManifestTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :manifest_tag_relations do |t|
      t.references :manifest, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
