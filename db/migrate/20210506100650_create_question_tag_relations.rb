class CreateQuestionTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :question_tag_relations do |t|
      t.references :question, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
