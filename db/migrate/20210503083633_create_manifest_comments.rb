class CreateManifestComments < ActiveRecord::Migration[6.0]
  def change
    create_table :manifest_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :manifest, null: false, foreign_key: true
      t.string :content
      t.timestamps
    end
  end
end
