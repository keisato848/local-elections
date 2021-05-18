class CreateQuestionComments < ActiveRecord::Migration[6.0]
  def change
    create_table :question_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :content
      t.timestamps
    end
  end
end
