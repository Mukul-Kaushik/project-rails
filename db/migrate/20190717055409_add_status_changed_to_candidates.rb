class AddStatusChangedToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :status_changed, :date
  end
end
