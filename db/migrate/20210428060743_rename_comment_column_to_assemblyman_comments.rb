class RenameCommentColumnToAssemblymanComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :assemblyman_comments, :comment, :content
  end
end
