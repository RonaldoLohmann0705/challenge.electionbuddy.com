class AddUpdatedByToVoters < ActiveRecord::Migration[6.1]
  def change
    add_column :voters, :updated_by, :integer
  end
end
