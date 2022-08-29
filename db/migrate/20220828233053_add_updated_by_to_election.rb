class AddUpdatedByToElection < ActiveRecord::Migration[6.1]
  def change
    add_column :elections, :updated_by, :integer
  end
end
