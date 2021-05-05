class CreateElections < ActiveRecord::Migration[6.0]
  def change
    create_table :elections do |t|
      t.date :day, null: false
      t.references :council, null: false
      t.timestamps
    end
  end
end
