class ChangeCommentsToAssemblymanComments < ActiveRecord::Migration[6.0]
  def change
    rename_table :comments, :assemblyman_comments
  end
end
