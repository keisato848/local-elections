class RemoveColumnAssemblymen < ActiveRecord::Migration[6.0]
  def change
    remove_column :assemblymen, :election_day
  end
end
