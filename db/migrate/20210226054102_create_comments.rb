class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user_id, null: false
      t.references :assemblyman_id, null: false
      t.text :comment
      t.timestamps
    end
  end
end
