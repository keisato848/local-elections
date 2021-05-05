class RemoveColumnCouncils < ActiveRecord::Migration[6.0]
  def change
    remove_column :councils, :election_day
  end
end
