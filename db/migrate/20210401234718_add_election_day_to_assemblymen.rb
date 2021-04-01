class AddElectionDayToAssemblymen < ActiveRecord::Migration[6.0]
  def change
    add_column :assemblymen, :election_day, :date
  end
end
