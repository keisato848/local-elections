class AddElectionDayToCouncils < ActiveRecord::Migration[6.0]
  def change
    add_column :councils, :election_day, :date
  end
end
