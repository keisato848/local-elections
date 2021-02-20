class CreateCouncils < ActiveRecord::Migration[6.0]
  def change
    create_table :councils do |t|
      t.string :name, null: false
      t.references :prefecture, null: false, foreign_key: true
      t.timestamps
    end
  end
end
