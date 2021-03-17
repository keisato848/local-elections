class CreateAssemblymen < ActiveRecord::Migration[6.0]
  def change
    create_table :assemblymen do |t|
      t.string :name, null: false
      t.string :faction, null: false
      t.string :sex, null: false
      t.date :birth_of_date, null: false
      t.string :faction, null: false
      t.integer :number_of_wins, null: false
      t.text :img_url, null: false
      t.string :job
      t.text :twitter_url
      t.references :council, null: false, foreign_key: true
      t.timestamps
    end
  end
end
