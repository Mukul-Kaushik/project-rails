class AddMobilityToCandidate < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :mobility, :string
  end
end
