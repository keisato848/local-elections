class AddIndexIdAndTitleToManifests < ActiveRecord::Migration[6.0]
  def change
    add_index :manifests, :title, unique: true
  end
end
