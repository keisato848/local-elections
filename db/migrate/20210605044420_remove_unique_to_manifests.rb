class RemoveUniqueToManifests < ActiveRecord::Migration[6.0]
  def up
    remove_index :manifests, :title
    add_index :manifests, :title
  end

  def down
    remove_index :manifests, :title
    add_index :manifests, :title, unique: true
  end
end
