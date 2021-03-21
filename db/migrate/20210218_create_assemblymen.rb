class CreateAssemblymen < ActiveRecord::Migration[6.0]
  def change
    create_table :assemblymen do |t|
      t.string :name, null: false
      t.string :sex
      t.date :birth_of_date
      t.string :position
      t.string :faction
      t.integer :number_of_wins
      t.string :img_url
      t.string :job
      t.text :twitter_url
      t.references :council, null: false, foreign_key: true
      t.references :user
      t.timestamps
    end
  end
end
