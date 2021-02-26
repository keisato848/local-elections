class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :assemblyman, null: false
      t.text :comment
      t.timestamps
    end
  end
end
