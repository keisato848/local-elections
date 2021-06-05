class RemoveUniqueToQuestions < ActiveRecord::Migration[6.0]
  def up
    remove_index :questions, :title
    add_index :questions, :title
  end

  def down
    remove_index :questions, :title
    add_index :questions, :title, unique: true
  end
end
